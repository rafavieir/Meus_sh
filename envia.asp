<%
Set Upload = Server.CreateObject("Persits.Upload")
n = Upload.Save("\\warriors0014-w-spa.fs.locaweb.com.br\WNFS-0003\jwcomercioltda1\web\teste\uploads")
response.write n & " arquivo(s) foram enviados com sucesso."
Set Upload = nothing
%>
