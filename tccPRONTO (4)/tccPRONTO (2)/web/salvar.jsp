<%@page import="java.sql.Connection" %>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.*" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Agendado</title>
        <style>
         body {
            font-family: Arial, sans-serif;
            background-color: #f4f7fa;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        /* Container principal */
        .container {
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 80%;
            max-width: 600px;
            text-align: center;
        }

        /* Título da página */
        h1 {
            color: #333;
            font-size: 28px;
            margin-bottom: 20px;
        }

        /* Estilo para mensagens de sucesso e erro */
        .sucesso {
            color: #9c9898;
            font-size: 18px;
            margin: 10px 0;
            font-weight: bold;
        }

        .erro {
            color: #dc3545;
            font-size: 18px;
            margin: 10px 0;
            font-weight: bold;
        }

        /* Estilo para mensagens de erro no Java */
        .erro-js {
            color: #007bff;
            font-size: 16px;
        }
    </style>
    </head>
    <body>
         <div class="container">
        <h1>Agendado!!</h1>
        
        <%
            String nome;
            String email;
            String numero;
            String tratamento;
            String convenio;
            int dia;
            String mes;
            int ano;
            String horario;

            nome = request.getParameter("nome");
            email = request.getParameter("email"); 
            numero = request.getParameter("numero"); 
            tratamento = request.getParameter("tratamento");
            convenio = request.getParameter("convenio"); // Pegando o valor do campo convenio
            dia = Integer.parseInt(request.getParameter("dia"));
            mes = request.getParameter("mes"); 
            ano = Integer.parseInt(request.getParameter("ano")); 
            horario = request.getParameter("horario");

            // Se o convenio for vazio ou nulo, definir um valor padrão
            if (convenio == null || convenio.trim().isEmpty()) {
                convenio = "não informado"; // Valor padrão caso o campo esteja vazio
            }

            try {
                // Fazendo a conexão com o banco de dados
                Connection conecta;
                PreparedStatement st;
                Class.forName("com.mysql.cj.jdbc.Driver");
                String url = "jdbc:mysql://localhost:3306/odonto_clinica";
                String user = "root";
                String password = "";
                conecta = DriverManager.getConnection(url, user, password);

                // Inserindo dados na tabela agenda do BD
                String sql = "INSERT INTO agenda (nome, email, numero, tratamento, convenio, dia, mes, ano, horario) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
                st = conecta.prepareStatement(sql);
                st.setString(1, nome);
                st.setString(2, email);
                st.setString(3, numero);
                st.setString(4, tratamento);
                st.setString(5, convenio); // Aqui, convenio não pode ser nulo
                st.setInt(6, dia);
                st.setString(7, mes);
                st.setInt(8, ano);
                st.setString(9, horario);

                st.executeUpdate(); // Executa o comando insert
                out.print("<p class='sucesso'>Cadastro realizado com sucesso!</p>");
            } catch (Exception e) {
                String erro = e.getMessage();
                out.print("<p class='erro'>Mensagem de erro: " + erro + "</p>");
            }
        %>
    </body>
</html>
