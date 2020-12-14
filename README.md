# SFTP Deploy action

> Use this action to deploy your files to an sftp server

## Inputs

### `username`

**Required** sftp username.

### `password`

**Required** sftp password.

### `server`

**Required** sftp server address.

### `port`

sftp server port , default `22`

### `ssh_private_key`

 **Required** you can copy private_key from your `ssh_private_key.pem file`, keep format, and save at`repo/settings/secrets`. Use a private key without passphrase.

### `local_path`

 **Required** `local_path` of your project, if you want put single file:use path like `./myfile`, if you want put directory: use path like `./static/*`, it will put all files under `static` directory. Default to `./*`(will put all files in your repo).

### `remote_path`
 **Required** remote_path

### `args`
args of sftp cmd, E.g.`-o ConnectTimeout=5`


## Action Example	


	on: [push]

	jobs:
	  deploy_job:
	    runs-on: ubuntu-latest
	    name: deploy
	    steps:
	      - name: Checkout
	        uses: actions/checkout@v2
	      - name: deploy file
	        uses: Panenco/panenco-sftp-deploy-action@v3
	        with:
	          username: 'root'
	          server: 'your server ip'
	          ssh_private_key: ${{ secrets.SSH_PRIVATE_KEY }} 
	          local_path: './static/*'
	          remote_path: '/var/www/app'
	          args: '-o ConnectTimeout=5'
