<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>usedTrade</title>
</head>
<body>
	UsedTradePage
	<table width="80%">
		<thead>
			<tr bgcolor="#87CEFA">
				<th width="10%">등록번호</th>
				<th width="40%%">제목</th>
				<th width="10%">작성자</th>
				<th width="10%">작성일</th>
				<th width="10%">조회수</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${userTrades }" var="userTrade">
				<tr>
					<td>${userTrade.used_trade_seq }</td>
					<td>${userTrade.title }</td>
					<td>${userTrade.reg_name }</td>
					<td>${userTrade.reg_date }</td>
					<td>${userTrade.read_count }</td>
				</tr>
			</c:forEach>
			<tr align="center">
				<td>1022</td>
				<td>Galaxy note2 팝니다.</td>
				<td>리오네</td>
				<td>18:52</td>
				<td>10</td>
			</tr>
			<tr align="center">
				<td>1021</td>
				<td>아이폰6s 가격인하.</td>
				<td>보라빛향기</td>
				<td>16:52</td>
				<td>100</td>
			</tr>
			<tr align="center">
				<td>1022</td>
				<td>Galaxy note2 팝니다.</td>
				<td>리오네</td>
				<td>18:52</td>
				<td>10</td>
			</tr>
			<tr align="center">
				<td>1021</td>
				<td>아이폰6s 가격인하.</td>
				<td>보라빛향기</td>
				<td>16:52</td>
				<td>100</td>
			</tr>
			<tr align="center">
				<td>1022</td>
				<td>Galaxy note2 팝니다.</td>
				<td>리오네</td>
				<td>18:52</td>
				<td>10</td>
			</tr>
			<tr align="center">
				<td>1021</td>
				<td>아이폰6s 가격인하.</td>
				<td>보라빛향기</td>
				<td>16:52</td>
				<td>100</td>
			</tr>
			<tr align="center">
				<td>1022</td>
				<td>Galaxy note2 팝니다.</td>
				<td>리오네</td>
				<td>18:52</td>
				<td>10</td>
			</tr>
			<tr align="center">
				<td>1021</td>
				<td>아이폰6s 가격인하.</td>
				<td>보라빛향기</td>
				<td>16:52</td>
				<td>100</td>
			</tr>
			<tr align="center">
				<td>1020</td>
				<td>블루투스 스피커 팔아요.</td>
				<td>너는너</td>
				<td>2016.04.22</td>
				<td>401</td>
			</tr>
			<tr align="center">
				<td>1020</td>
				<td>블루투스 스피커 팔아요.</td>
				<td>너는너</td>
				<td>2016.04.22</td>
				<td>401</td>
			</tr>
		</tbody>
	</table>
</body>