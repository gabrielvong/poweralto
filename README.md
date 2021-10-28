<B>HIGH LEVEL HOW TO</B>

<B>On Panorama</B>

1. Using your Panorama username/password, generate an API key
  https://panorama/api/?type=keygen&user=mxxxx&password=xxxx

<B>On Your PC</B>

2. Install PowerAlto on your PC's Powershell (One off exercise)
  <i>Install-Module PowerAlto</i>
3. Connect to Panorama from Powershell
  <i>Get-PaDevice -DeviceAddress [panorama IP] -ApiKey [apikey]</i>
4. Run Scripts to commit changes to Panorama
5. Push the change to device - you need to use the same account as step 1, otherwise it will cuase an error.
