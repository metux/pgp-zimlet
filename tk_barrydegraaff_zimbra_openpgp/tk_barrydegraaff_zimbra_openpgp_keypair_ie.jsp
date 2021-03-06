<%/*
This file is part of the Zimbra OpenPGP Zimlet project.
Copyright (C) 2014  Barry de Graaff

Bugs and feedback: https://github.com/barrydegraaff/pgp-zimlet/issues

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see http://www.gnu.org/licenses/.

Zimbra caches jsp files that will persist until you issue:
zmmailboxdctl restart
Normal cache flush does NOT work
*/
%><!DOCTYPE html>
<html><head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Zimbra OpenPGP Zimlet</title>
<script src="/service/zimlet/_dev/tk_barrydegraaff_zimbra_openpgp/openpgp.js"></script>
</head>
<body style="font-family:sans-serif"><b>New key pair</b>
<textarea style="display:none" readonly id="userid" rows="20" cols="100"><%= request.getParameter("userid")%></textarea>
<textarea style="display:none" readonly id="passphrase" rows="20" cols="100"><%= request.getParameter("passphrase")%></textarea>
<input style="display:none" readonly id="keyLength" value="<%= request.getParameter("keyLength")%>">
<script type="text/javascript">
var openpgp = window.openpgp;

try {
   var passphrase = document.getElementById('passphrase').value;
   var userid = document.getElementById('userid').value;
   var keyLength = document.getElementById("keyLength").value;
   //var key = openpgp.generateKeyPair(openpgp.enums.publicKey.rsa_encrypt_sign, 512, userid, passphrase);
   var key = openpgp.generateKeyPair({numBits: keyLength, userId: userid, passphrase: passphrase});

   document.write('<br><br>Please make sure to store this information in a safe place:<br><textarea rows="20" cols="100">Passphrase ' + passphrase + ' for ' + userid + '\r\n\r\n'+key.privateKeyArmored+'\r\n\r\n'+key.publicKeyArmored+'\r\n\r\nKey length: '+keyLength+' bits</textarea>');
}
catch (err) {
   document.write('<pre>Could not generate key pair.</pre>');
}
</script>
<br><br><small>Tip: CTRL+W to close this tab.</small>
</body>
</html>
