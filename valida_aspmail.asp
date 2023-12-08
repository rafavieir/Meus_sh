<%
If Request.ServerVariables("REQUEST_METHOD") = "POST" Then
    ' Recebendo dados do formulário
    Dim destinatario, mensagem
    destinatario = Request.Form("destinatario")
    mensagem = Request.Form("mensagem")
    
    ' Configurando as variáveis para o envio de e-mail
    Dim AspEmail, nomeRemetente, emailRemetente, emailRetorno, assunto, servidor
    
    nomeRemetente = "Lw teste"
    emailRemetente = "locaweb@www191.locaweb.com.br"
    emailRetorno = "locaweb@www191.locaweb.com.br"
    assunto = "Teste AspEmail"
    servidor = "localhost"
    
    ' Instanciando o objeto AspEmail
    Set AspEmail = Server.CreateObject("Persits.MailSender")
    
    ' Configurando as propriedades do AspEmail
    AspEmail.Host = servidor
    AspEmail.FromName = nomeRemetente
    AspEmail.From = emailRemetente
    AspEmail.MailFrom = emailRemetente
    
    AspEmail.AddReplyTo emailRetorno
    AspEmail.AddAddress destinatario
    AspEmail.Subject = assunto
    AspEmail.IsHTML = True
    AspEmail.Body = mensagem
    
    ' Tratamento de erros
    On Error Resume Next
    
    ' Enviando a mensagem
    AspEmail.Send
    
    ' Tratando erros, se houver
    If Err <> 0 Then
        erro = "<b><font color='red'>Erro ao enviar a mensagem.</font></b><br>"
        erro = erro & "<b>Erro.Description:</b> " & Err.Description & "<br>"
        erro = erro & "<b>Erro.Number:</b> " & Err.Number & "<br>"
        erro = erro & "<b>Erro.Source:</b> " & Err.Source & "<br>"
        Response.Write erro
    Else
        Response.Write "<font color='blue'><b>Mensagem enviada com sucesso para</b></font> " & destinatario
    End If
    
    ' Removendo a referência do componente da memória
    Set AspEmail = Nothing
Else
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <title>Envio de Mensagem</title>
</head>
<body style="background-color: #263645;">

    <div class="container mt-5 text-center">
            <br>
            <img src="https://raw.githubusercontent.com/euforo/Meus_sh/main/misc/versow.gif">
            <br>
        <div class="alert alert-success" role="alert" style="background-color: #4CAF50; color: white;">
            <font color="white"><marquee>O AspEmail está instalado corretamente.</marquee><br>
            Clique <a href="#" onclick="mostrarForm()">aqui</a> para enviar uma mensagem de teste
        </font>
    </div>

    <!-- Formulário oculto inicialmente -->
    <div class="container mt-5" id="formulario" style="display: none;">
        <form action="" method="post">
            <div class="form-group">
                <label for="destinatario" style="color: white;">Destinatário:</label>
                <input type="text" class="form-control" id="destinatario" name="destinatario" required>
            </div>
            <div class="form-group">
                <label for="mensagem" style="color: white;">Mensagem:</label>
                <textarea class="form-control" id="mensagem" name="mensagem" rows="3" required></textarea>
            </div>
            <button type="submit" class="btn btn-primary">Enviar Mensagem</button>
        </form>
    </div>

    <script>
        function mostrarForm() {
            document.getElementById("formulario").style.display = "block";
        }
    </script>

</body>
</html>
<%
End If
%>
