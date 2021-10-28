High level how to:
On Panorama
1. Obtain API key from Panorama
  https://panorama/api/?type=keygen&user=mxxxx&password=xxxx

On Your PC
2. Install PowerAlto on your PC's Powershell (One off exercise)
  Install-Module PowerAlto
3. Connect to Panorama
  Get-PaDevice -DeviceAddress [panorama IP] -ApiKey [apikey]
4. Run Scripts
