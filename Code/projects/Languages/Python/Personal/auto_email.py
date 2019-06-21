# Scott Holley
# June 20th, 2018
# Automated email generation
import smtplib as sm

# grab contact info from csv file on computer
def contact(filepath: str):
    foo = open(filepath)
    contact.email_list = []
    line = foo.readlines()
    for contact.email in line:
        contact.email_list.append(contact.email)

    return contact.email_list

# setup the server and feed the names of emails into function to send email
def mailing_setup():
    contact('/home/river/Desktop/test.csv')

    custom_message = str(input("Enter your message below. When finished, press Enter: \n"))
    Message = "Subject: Summer Crossing Message to Residents: \n" + custom_message + "\n\nThis code was autogenerated."

    gmail_sender = 'denvercoder2@gmail.com'
    # password is removed for obvious reasons
    gmail_passwd = '*'
    # open secure server
    server = sm.SMTP_SSL('smtp.googlemail.com', 465)
    server.ehlo()
    # credential login
    server.login(gmail_sender, gmail_passwd)
    # for every email in the list, send them an email with the above parameters
    for email in contact.email_list:
        Reciever = email
        try:
            server.sendmail(gmail_sender, Reciever, Message)
            print ('\nEmail was sent to: ', email)
        except:
            print ('Problem with sending email... If problem persists, contact Scott')
    # kill the server after the send
    server.quit()


def main():
    mailing_setup()


if __name__ == "__main__":
    print("Welcome to the Automated Email Sendout.\n")
    main()