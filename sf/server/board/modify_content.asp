<!--METADATA type="typelib" file="c:\Program Files\Common Files\SYSTEM\ADO\msado15.dll"-->
<%@Language="VBScript" CODEPAGE="65001" %>
<%Option Explicit%>

<!--#include file="../../include/JSON_2.0.4.asp"-->
<!--#include file="../../include/JSON_UTIL_0.1.1.asp"-->

<%
Response.CharSet = "UTF-8"
Response.ContentType = "application/json"

	Dim strDbName
	Dim strDbUserId
	Dim strDbUserPwd
	Dim strDbIp
	Dim DB
	Dim strConnection	
	Dim col

	strDbName = "MuticampusVue"	'데이터베이스 이름
	strDbUserId = "sa"	'데이터베이스 ID
	strDbUserPwd = "P@4002732!"	'데이터베이스 PW
	'strDbIp = "127.0.0.1"	'데이터베이스 IP
	strDbIp = "KOHLAIT2302041\SQLEXPRESS"	'데이터베이스 IP	

	strConnection = "Provider=SQLOLEDB;Data Source="& strDbIp &";Initial Catalog="& strDbName &";User ID="&strDbUserId&";Password="&strDbUserPwd&";Persist Security Info=True;"
	Set DB = Server.CreateObject("ADODB.Connection")
	DB.Open strConnection

' ------------------------------
' 사용자정의함수
' ------------------------------
' DB 연결 사용안함

Function dbCon(host, name, user, pass)
	Set DB = Server.CreateObject("ADODB.Connection")

	strCon = "Provider=SQLOLEDB;Data Source=" & host & ";Initial Catalog=" & name & ";User ID=" & user & ";Password=" & pass & ";Persist Security Info=True;"

	DB.Open strCon
End Function

' DB 닫기
Function dbClose() 
	DB.Close 
	Set DB = Nothing 
End Function

Dim chk
Dim contentIdx, contentSubject, contentText, contentFile
Dim strSQL

contentIdx = Request("content_idx")
contentSubject = Request("content_subject")
contentText = Request("content_text")
contentFile = Request("content_file")
'intBoardIdx = 1


'Response.write contentIdx & "/" & contentSubject & "/" & contentText & "/" & contentFile
'Response.end

strSQL = "update content_table set "
strSQL = strSQL & " content_subject = '"&contentSubject&"'"
strSQL = strSQL & " , content_text = '"&contentText&"'"

If contentFile <> "" And not IsNull(contentFile) Then
	strSQL = strSQL & " , content_file = '"&contentText&"'"
End If
strSQL = strSQL & " where content_idx = " & contentIdx

DB.Execute strSQL

IF Err.number <> 0 Then
	chk = CBool(false)
	Response.write Err.number
	Response.write "에러"
	'Response.write "result:false"
	'DB.RollbackTrans	
	DB.Close
	Set DB = Nothing
Else
	chk = CBool(true)
	'Response.write True
	'Response.write "result:true"
	DB.Close
	Set DB = Nothing
End If	
%>
{
	"result" : "<%=chk%>"
}