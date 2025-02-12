<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.PreparedStatement"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Atualizar produto</title>
</head>
<body>
    <%
    // Recebe os dados do formulário
   
    String nome = request.getParameter("nome");
    String email = request.getParameter("email");
    String numero = request.getParameter("numero");
    String tratamento = request.getParameter("tratamento");
    String convenio = request.getParameter("convenio");
    int dia = Integer.parseInt(request.getParameter("dia"));
    String mes = request.getParameter("mes");
    int ano = Integer.parseInt(request.getParameter("ano")); 
    String horario = request.getParameter("horario");
    // Conecta ao banco de dados
    Class.forName("com.mysql.cj.jdbc.Driver");
    String url = "jdbc:mysql://localhost:3306/odonto_clinica";
    String user = "root";
    String password = "";
    Connection conecta = DriverManager.getConnection(url, user, password);

    // Atualiza o registro
    String sql = "UPDATE agenda SET nome=?, email=?, numero=?, tratamento=?, convenio=?, dia=?, mes=?, ano=?, horario=? WHERE email=?";

    PreparedStatement st = conecta.prepareStatement(sql);
    st.setString(1, nome);  // nome
st.setString(2, email);  // email
st.setString(3, numero);  // numero
st.setString(4, tratamento);  // tratamento
st.setString(5, convenio);  // convenio
st.setInt(6, dia);  // dia
st.setString(7, mes);  // mes
st.setInt(8, ano);  // ano
st.setString(9, horario);  // horario
st.setString(10, email);  
    st.executeUpdate();

    // Fecha a conexão
    conecta.close();

    // Redireciona para consultar.jsp
    response.sendRedirect("adm.jsp");
    %>
</body>
</html>