<B>HIGH LEVEL HOW TO</B>
<B>IT IS STRONGLY RECOMMENDED FOR YOU TO TRY OUT THE SCRIPT ON LAB ENVRIONMENT, KNOWING HOW IT BEHAVES BEFORE RUNNING ON PRODUCTION EVRIONMENT.</B>


<B>On Panorama</B>
1. Using your own Panorama username/password, generate an API key, keep it in a your password safe. This API key is hashed out of your password so it will remain valid until your Panorama account's password changes:
  https://panorama/api/?type=keygen&user=mxxxx&password=xxxx

<B>On Your PC</B>
1. Open Powershell ISE
2. Install PowerAlto via Powershell (One off exercise):
  <i>Install-Module PowerAlto</i>
3. Connect to Panorama from Powershell:
  <i>Get-PaDevice -DeviceAddress [panorama IP] -ApiKey [apikey]</i>
4. Download BulkAddressAdd.psi to your PC, open the script in Powershell ISE, read/follow the instructions on the script to define the envrionment variables
5. Run Script to create changes to Panorama (NOTE the changes are NOT submitted)
6. Go to Panorama GUI to preview the changes made by the script before commit (you need to login to panorama GUI with the account you used at step 1, otherwise it will cuase commit/auditing error)
7. Commit the change
8. Push the change to device(s) 
