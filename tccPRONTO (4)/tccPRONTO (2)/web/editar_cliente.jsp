<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.SQLException"%>

<%@ page language="java" contentType="text/html" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Atualizar Agenda</title>
    </head>
    <body>
        <form method="post" action="editar.jsp"> 

            <%
                // Obtém os parâmetros do formulário
                String nome = request.getParameter("nome");
                String email = request.getParameter("email");
                String numero = request.getParameter("numero");
                String tratamento = request.getParameter("tratamento");
                String convenio = request.getParameter("convenio");
                String dia = request.getParameter("dia");
                String mes = request.getParameter("mes");
                String ano = request.getParameter("ano");
                String horario = request.getParameter("horario");

                // Obtém o id diretamente como um inteiro
                int id = Integer.parseInt(request.getParameter("id"));

      

                Connection conecta = null;
                PreparedStatement st = null;

                try {
                    // Conecta com o banco de dados
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    String url = "jdbc:mysql://localhost:3306/odonto_clinica";
                    String user = "root";
                    String password = "";
                    conecta = DriverManager.getConnection(url, user, password);

                    // Comando SQL de atualização
                    String updateSql = "UPDATE agenda SET nome = ?, email = ?, numero = ?, tratamento = ?, convenio = ?, dia = ?, mes = ?, ano = ?, horario = ? WHERE id = ?";
                    st = conecta.prepareStatement(updateSql);
                    st.setString(1, nome);
                    st.setString(2, email);
                    st.setString(3, numero);
                    st.setString(4, tratamento);
                    st.setString(5, convenio);
                    st.setString(6, dia);
                    st.setString(7, mes);
                    st.setString(8, ano);
                    st.setString(9, horario);
                    st.setInt(10, id); // ID tratado como INT no SQL

                    // Verificação da consulta SQL
                    int rowsUpdated = st.executeUpdate();

                    // Depuração: exibe o resultado da atualização
                    if (rowsUpdated > 0) {
                      out.println("<p style='color: #28a745; font-size: 16px; text-align: center; font-weight: bold;'>Registro atualizado com sucesso!</p>");
                      

                    } else {
                        out.println("<p>Falha na atualização do registro. Nenhum registro foi alterado.</p>");
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                    out.println("<p>Erro de SQL: " + e.getMessage() + "</p>");
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<p>Erro geral: " + e.getMessage() + "</p>");
                } finally {
                    // Fechar recursos
                    if (st != null) try { st.close(); } catch (SQLException e) {}
                    if (conecta != null) try { conecta.close(); } catch (SQLException e) {}
                }
            %>
        </form>
    </body>
</html>
