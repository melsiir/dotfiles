
# add google drive to headless terminal

1. first install

google-drive-ocamlfuse

sudo add-apt-repository ppa:alessandro-strada/ppa
sudo apt-get update
sudo apt-get install google-drive-ocamlfuse

2. then create google credentials

* Sign in to your Google account and create a project: <https://console.cloud.google.com/>
Enable the Google Drive API
In the left-hand pane (Navigation menu), open "APIs & Services" -> "Library", this will take you to <https://console.cloud.google.com/apis/library>
Click on "Google Drive API", this will open <https://console.cloud.google.com/apis/library/drive.googleapis.com> . Click "ENABLE API".

* Get your client ID and client secret
Open the Navigation menu (click the hamburger icon at the top left), open "APIs & Services" -> "Credentials", this will open <https://console.cloud.google.com/apis/credentials>
Then click on the button "Create Credentials", and choose choose "OAuth client ID", this will take you to <https://console.cloud.google.com/apis/credentials/oauthclient> .

* For Application type, choose "Other" or "Desktop"
For Name, input something personal, for example "My OCAMLDrive".
Click "Create". You will get a Client ID, a Client Secret.

* and dont for get to make auth consent screen and add at least one tester with your gmail

3. Authorization: Back in your headless server, run google-drive-ocamlfuse for the first time. I used labels (in this document, I use the label "me") because I plan on using multiple accounts. However you can also run it without the -label parameter and it will use a default name for the label called "default". You will need the Client ID and secret you got from google above.

From version 0.5.3, you should use the -headless option:

google-drive-ocamlfuse -headless -label me -id ##yourClientID##.apps.googleusercontent.com -secret ###yoursecret#####

You will get

Please, open the following URL in a web browser: <https://accounts.google.com/o/oauth2/auth?client_id=##yourClientID##.apps.googleusercontent.com&redirect_uri=urn%3Aietf%3Awg%3Aoauth%3A2.0%3Aoob&scope=https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fdrive&response_type=code&access_type=offline&approval_prompt=force>

 4. That's it. You should be ready to mount.

  mkdir /drive
 google-drive-ocamlfuse -label me /drive

Finally, to unmount, elsewhere in the instructions it says to use fusermount -u mountpoint. That did not work for me for some reason, but umount mountpoint did.

then you can copy easly into google drive via

cp anything.zip drivei

# install gogole cloud and run google shell from termux

run

```
pkg install python openssh
curl -o sdk.sh sdk.cloud.google.com
chmod +x sdk.sh
./sdk.sh --install-dir=$PREFIX

```

Now just attend few questions and authenticate yourself.
 reload shell so that all Commmand reloads in your PATH

`gcloud auth login`

copy link and paste in your default browser, Choose account and copy code then fill that in  terminal. now done.

 Let's do ssh in cloud shell.

`gcloud cloud-shell ssh`
