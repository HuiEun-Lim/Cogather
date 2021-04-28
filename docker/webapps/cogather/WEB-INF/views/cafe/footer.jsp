<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
          integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
 
<style>
.clear{
	clear:both;
}
.social-links {
    float: none;
    text-align: center;
    padding-top: 10px;
}

.social-link {
    margin-right: 10px;
    width: 40px;
}

.footer {
    background-color: #464646;
    padding-top: 20px;
    padding-bottom: 20px;
}

.webscope-text {
    color: white;
    font-size: 12px;
    padding-right: 7px;
}

.webscope {
    text-align: center;
    margin-top: -5px;
}
img{vertical-align: middle;}
#copyright{margin-top: 14px;}
    </style>
</head>

<body>

<div class="footer">

    <div class="container">
        <div class="row">
            <div class="col-sm-2"></div>
            <div class="col-sm-8 webscope">
                <span class="webscope-text"> Study with </span>
                <a href="${pageContext.request.contextPath}"> <img src="../img/logo_cut.png" style="width: 80px"/> </a>
                <div id="copyright">Copyright(c) 2021 Cogather All rights Reserved.</div>
            </div>
            <div class="col-sm-2">
                <div class="social-links">
                    <a href="https://github.com/HuiEun-Lim/Cogather">
                    <img class="social-link" src="../img/cafe/git.png"/></a>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>