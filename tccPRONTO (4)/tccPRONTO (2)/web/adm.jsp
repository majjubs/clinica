<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.*"%>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>Consultar</title>
  <link rel="stylesheet" href="consultar.css"/>
</head>
<body>
<%
Connection conecta = null;
PreparedStatement st = null;
ResultSet rs = null;

try {
  // Conexão com o banco de dados
  Class.forName("com.mysql.cj.jdbc.Driver");
  String url = "jdbc:mysql://localhost:3306/odonto_clinica";
  String user = "root";
  String password = "";
  conecta = DriverManager.getConnection(url, user, password);
  
  // Verifica se a conexão foi bem-sucedida
  if (conecta == null) {
    throw new Exception("Falha na conexão com o banco de dados.");
  }
  
  // Lista os dados da tabela agenda do banco de dados
  String sql = "SELECT * FROM agenda";
  st = conecta.prepareStatement(sql);
  rs = st.executeQuery();
%>

<table border="1">
  <header>
    <a href="index.html">Voltar</a>
    <h1>Consultar</h1>
  </header>
  <tr>
    <th>Nome</th>
    <th>Email</th>
    <th>Numero</th>
    <th>Tratamento</th>
    <th>Convenio</th>
    <th>Dia</th>
    <th>Mês</th>
    <th>Ano</th>
    <th>Horário</th>
    <th>ID</th> <!-- Coluna ID na 10ª posição -->
    <th>Ações</th>  <!-- Coluna Ações fica na última posição -->
  </tr>
<% 
while (rs.next()) { 
  int id = rs.getInt("id");
%>
  <tr>
    <td><%= rs.getString("nome") %></td>
    <td><%= rs.getString("email") %></td>
    <td><%= rs.getString("numero") %></td>
    <td><%= rs.getString("tratamento") %></td>
    <td><%= rs.getString("convenio") %></td>
    <td><%= rs.getString("dia") %></td>
    <td><%= rs.getString("mes") %></td>
    <td><%= rs.getString("ano") %></td>
    <td><%= rs.getString("horario") %></td>
    <td><%= id %></td>  <!-- Exibe o ID na 10ª posição -->
    <td class="acoes">
      <a href="editar.jsp?id=<%= id %>">
        <img src="icons/editar.svg" alt="Editar" class="icon">
      </a>
      <a href="excluir.jsp?id=<%= id %>">
        <img src="icons/lixeira.svg" alt="Excluir" class="icon">
      </a>
    </td>
  </tr>
<% 
} 
%>
</table>
<% 
} catch (Exception e) {
  e.printStackTrace();  // Exibe a stack trace no console para depuração
  out.print("Erro: " + e.getMessage());  // Exibe a mensagem de erro no HTML
} finally {
  // Fechar recursos
  try {
    if (rs != null) rs.close();
    if (st != null) st.close();
    if (conecta != null) conecta.close();
  } catch (SQLException e) {
    out.print("Erro ao fechar recursos: " + e.getMessage());
  }
}
%>
</body>
</html>
