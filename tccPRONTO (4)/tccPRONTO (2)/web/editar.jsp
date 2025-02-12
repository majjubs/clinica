<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>

<%@ page language="java" contentType="text/html" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Alterar Agenda</title>
        <link rel="stylesheet" href="editar.css">
    </head>
    <body>
        <%
            // Conexão com o banco de dados
            Connection conecta = null;
            PreparedStatement st = null;
            ResultSet resultado = null;
            
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                String url = "jdbc:mysql://localhost:3306/odonto_clinica";
                String user = "root";
                String password = "";
                conecta = DriverManager.getConnection(url, user, password);

                // Pega o ID passado pela URL para buscar o registro específico
                String id = request.getParameter("id");
                if (id != null && !id.isEmpty()) {
                    // Consulta para buscar o registro específico
                    String sql = "SELECT * FROM agenda WHERE id = ?";
                    st = conecta.prepareStatement(sql);
                    st.setString(1, id);
                    resultado = st.executeQuery();

                    // Verifica se o registro foi encontrado
                    if (resultado.next()) {
                        String nome = resultado.getString("nome");
                        String email = resultado.getString("email");
                        String numero = resultado.getString("numero");
                        String tratamento = resultado.getString("tratamento");
                        String convenio = resultado.getString("convenio");
                        String dia = resultado.getString("dia");
                        String mes = resultado.getString("mes");
                        String ano = resultado.getString("ano");
                        String horario = resultado.getString("horario");
                        String idValue = resultado.getString("id");
        %>

        <form method="post" action="editar_cliente.jsp">
            <header>Editar Agenda</header>
            <a href="adm.jsp">Voltar</a>

            <label for="nome">Nome</label>
            <input type="text" name="nome" id="nome" value="<%= nome %>" required>

            <label for="email">Email</label>
            <input type="text" name="email" id="email" value="<%= email %>" required>

            <label for="numero">Número</label>
            <input type="text" name="numero" id="numero" value="<%= numero %>" required>

            <label for="tratamento">Tratamento</label>
            <select id="tratamento" name="tratamento" required>
                <option value="implante" <%= tratamento.equals("implante") ? "selected" : "" %>>Implante</option>
                <option value="clareamento" <%= tratamento.equals("clareamento") ? "selected" : "" %>>Clareamento</option>
                <option value="faceta" <%= tratamento.equals("faceta") ? "selected" : "" %>>Faceta</option>
                <option value="checkup" <%= tratamento.equals("checkup") ? "selected" : "" %>>Check-up</option>
            </select>

            <label for="convenio">Convênio</label>
            <select id="convenio" name="convenio" required>
                <option value="amil" <%= convenio.equals("amil") ? "selected" : "" %>>Amil</option>
                <option value="brazil" <%= convenio.equals("brazil") ? "selected" : "" %>>Brazil Dental</option>
                <option value="sul" <%= convenio.equals("sul") ? "selected" : "" %>>SulAmérica</option>
            </select>

            <label for="dia">Dia</label>
            <input type="number" name="dia" id="dia" value="<%= dia %>" required min="1" max="31">

            <label for="mes">Mês</label>
            <input type="number" name="mes" id="mes" value="<%= mes %>" required min="1" max="12">

            <label for="ano">Ano</label>
            <input type="number" name="ano" id="ano" value="<%= ano %>" required min="2024" max="2025">

            <label for="horario">Horário</label>
            <input type="text" name="horario" id="horario" value="<%= horario %>" required>

            <input type="submit" value="Salvar">
            <input type="hidden" name="id" value="<%= idValue %>">
        </form>

        <%
                    } else {
                        out.print("Nenhum registro encontrado.");
                    }
                } else {
                    out.print("ID inválido.");
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                // Fecha a conexão com o banco de dados
                if (resultado != null) try { resultado.close(); } catch (Exception e) {}
                if (st != null) try { st.close(); } catch (Exception e) {}
                if (conecta != null) try { conecta.close(); } catch (Exception e) {}
            }
        %>
    </body>
</html>
