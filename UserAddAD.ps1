### Markus Pooch
### erstellt am 10.10.2020

# Dieses Script dient zum schnellen Erstellen von Usern in einem AD
# Kann natuerlich um alle AD Felder erweitert werden.
# AD Felder werden auf dieser Webseite aufgefuehrt:
# http://blog.dikmenoglu.de/2009/06/die-active-directory-attribute-hinter-den-feldnamen/

# Variablen definieren
# Die CSV Datei liegt im gleichen Verzeichnis
# Die OU ist intern.Users.Gebaeude.testumgebung.local

$Import =Import-CSV "userimport2.csv"
$OU = "OU=intern,OU=Users,OU=Gebaeude,dc=testumgebung,dc=local"
$AD = "testumgebung.local"


# Schleife, die über die CSV Datei laeuft. Das Passwort wird verschluesselt
# Man erkennt die Zuordnug aus AD Feldnamen und den Daten aus der CSV Datei.
foreach ($user in $Import){
  $password = $user.password | ConvertTo-SecureString -AsPlainText -Force

  New-ADUser -Name $user.name -GivenName $user.Vorname -Surname $user.Nachname `
  -OfficePhone $user.Rufnummer -Path $OU -AccountPassword $Password `
  -ChangePasswordAtLogon $True -Enabled $True `
  -UserPrincipalName ($user.name + '@' + $AD)
}
