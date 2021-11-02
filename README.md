<B>HIGH LEVEL HOW TO</B>

<B>On Panorama</B>

1. Using your own Panorama username/password, generate an API key, keep it in a your password safe. This API key is hashed out of your password so it will remain valid until your Panorama account's password changes:
  https://panorama/api/?type=keygen&user=mxxxx&password=xxxx

<B>On Your PC</B>

2. Install PowerAlto on your PC's Powershell (One off exercise):
  <i>Install-Module PowerAlto</i>
3. Connect to Panorama from Powershell:
  <i>Get-PaDevice -DeviceAddress [panorama IP] -ApiKey [apikey]</i>
4. Run Scripts to create changes to Panorama (NOTE the changes are NOT submitted)
5. Go to Panorama GUI to preview the changes made by the script before commit (you need to login to panorama GUI with the account you used at step 1, otherwise it will cuase commit/auditing error)
6. Commit the change
7. Push the change to device(s) 
