import subprocess
import os

# Get the target email address
target_email = input("Enter the target email address: ")

# Create the phishing email file
phishing_email_file = "phishing_email.txt"
with open(phishing_email_file, "w") as f:
    f.write(f"To: {target_email}\n")
    f.write("Subject: Security Alert\n")
    f.write("\n")
    f.write("Dear user,\n")
    f.write("\n")
    f.write("We have detected suspicious activity on your account. Please click the link below to verify your identity and secure your account.\n")
    f.write("\n")
    f.write("https://www.example.com/verify\n")
    f.write("\n")
    f.write("If you did not initiate this request, please ignore this email.\n")
    f.write("\n")
    f.write("Thank you,\n")
    f.write("Example Company\n")

# Send the phishing email
subprocess.run(["ssmtp", target_email, "<", phishing_email_file])

# Clean up
os.remove(phishing_email_file
