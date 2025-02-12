<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Excluir</title>
  <link rel="stylesheet" href="excluir.css"/>
    <script type="text/javascript">
        function confirmarExclusao(id) {
            // Exibe uma caixa de confirmação
            var confirmacao = confirm("Tem certeza que deseja excluir?");
            
            if (confirmacao) {
                // Se o usuário clicar em "OK", redireciona para a URL com o ID
                window.location.href = "excluir.jsp?id=" + id + "&confirmar=true";
            } else {
                // Se o usuário clicar em "Cancelar", não faz nada
                alert("A exclusão foi cancelada.");
            }
        }
    </script>
</head>
<body>

    <%
        // Recebe o ID da URL
        String id = request.getParameter("id");
        String confirmar = request.getParameter("confirmar");

        if (confirmar != null && confirmar.equals("true") && id != null) {
            try {
                // Conexão com o banco de dados
                Connection conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/odonto_clinica", "root", "");
                String sql = "DELETE FROM agenda WHERE id = ?";
                PreparedStatement st = conecta.prepareStatement(sql);
                st.setInt(1, Integer.parseInt(id));

                // Executa a exclusão
                int rowsAffected = st.executeUpdate();

                out.print("<div class='confirmation-box'>");
                if (rowsAffected > 0) {
                    out.print("<p class='message'> excluído com sucesso!</p>");
                } else {
                    out.print("<p class='message'>Erro ao excluir.</p>");
                }
                out.print("<a href='adm.jsp' class='back-btn'>Voltar</a>");
                out.print("</div>");

            } catch (Exception e) {
                out.print("<div class='confirmation-box'>");
                out.print("<p class='message'>Erro: " + e.getMessage() + "</p>");
                out.print("<a href='adm.jsp' class='back-btn'>Voltar</a>");
                out.print("</div>");
            }
        } else if (id != null) {
            // Se o ID for válido mas não foi confirmado, exibe um botão de confirmação
            out.print("<div class='confirmation-box'>");
            out.print("<p class='message'>Você tem certeza que deseja excluir?</p>");
            out.print("<button onclick='confirmarExclusao(" + id + ")'>Sim!</button>");
            out.print("<button onclick='window.location.href=\"adm.jsp\"' class='cancel-btn'>Não!</button>");
            out.print("</div>");
        } else {
            out.print("<div class='confirmation-box'>");
            out.print("<p class='message'>ID inválido.</p>");
            out.print("<a href='adm.jsp' class='back-btn'>Voltar</a>");
            out.print("</div>");
        }
    %>

</body>
</html>
