# Google Cloud SDK Installation on Termux

## Installation Steps

First, ensure you have Termux installed from a reliable source like [F-Droid](https://f-droid.org/) for better compatibility. Then follow the steps below in the Termux terminal.

### 1. Install prerequisites

Install Python, OpenSSH, and `curl`. These are required for the Google Cloud SDK.

```bash
pkg install python openssh curl -y
```

### 2. Download the installation script

Fetch the official Google Cloud SDK installation script.

```bash
curl -o install.sh https://dl.google.com/dl/cloudsdk/channels/rapid/install_google_cloud_sdk.bash
chmod +x install.sh
```

### 3. Run the installation script

Execute the script and specify an installation directory inside Termux’s accessible filesystem (`$PREFIX`).

```bash
./install.sh --install-dir=$PREFIX
```

Follow the prompts during installation. You may skip bundled components if you want to save storage space.

### 4. Add `gcloud` to your PATH

The installer usually offers to do this automatically. If it does not, add the following line manually and reload your shell.

For **Bash**:

```bash
echo "export PATH=\$PATH:\$PREFIX/google-cloud-sdk/bin" >> ~/.bashrc
source ~/.bashrc
```

For **Zsh** (replace `~/.bashrc` with `~/.zshrc`):

```bash
echo "export PATH=\$PATH:\$PREFIX/google-cloud-sdk/bin" >> ~/.zshrc
source ~/.zshrc
```

### 5. Authenticate with Google Cloud

Once installation is complete, authenticate your Google account.

```bash
gcloud auth login
```

This command prints a URL. Open it in your browser, sign in, grant permissions, and paste the verification code back into the Termux terminal.

---

## Accessing the Cloud Shell

After authentication, you can use `gcloud` commands to manage your Google Cloud resources.

To access the remote Google Cloud Shell environment directly from Termux via SSH:

```bash
gcloud cloud-shell ssh
```

This opens an interactive SSH session to your Cloud Shell, providing a persistent cloud-based terminal.
