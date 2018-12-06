package enmaf;
import java_cup.runtime.Symbol;
import java.util.LinkedList;
%%
%cupsym simbolo
%class scanner
%cup
%unicode
%public
%line
%char
%column
%ignorecase
%states INPUT, LISTA, HEADLINE, FORM, IMGLINK

comentarios     =([/]\*([^*]|[\r\n]|(\*+([^*/]|[\r\n])))*\*+[/])|([/][/].*)
tstring         =[\"] ([^\"\n]+|[^\"\n]?)* [\"\n]
numero          =[0-9]+ "."? [0-9]*
letra           =[a-zA-ZÑñ]+
iden            ={letra}({letra}|{numero}|"_")*
multicomment    =[/]\*([^*]|[\r\n]|(\*+([^*/]|[\r\n])))*\*+[/]
htmlcomment     =["<"]["!"]["-"]["-"][^]*["-"]["-"][">"]
%{
/*contamos comentarios y eso.*/
public static int htmltag=0;
public static int htmlcom=0;
public static int forms=0;

/* Lista con errores sintacticos */
public LinkedList<Errores> lista=new LinkedList<Errores>();
/* Metodo que es llamado al encontrar un error lexico */
private void ErrorScan(int linea, int columna, String valor){
lista.add(new Errores(linea, columna, "Error lexico en el caracter "+valor) );}
%}
%%
<YYINITIAL>{
"<ol>"  {htmltag=htmltag+1;yybegin(LISTA); {return new Symbol(simbolo.listas, yychar,yyline,new String(yytext())); }}
"<ul>"  {htmltag=htmltag+1;yybegin(LISTA); {return new Symbol(simbolo.listas, yychar,yyline,new String(yytext())); }}
"<dl>"  {htmltag=htmltag+1;yybegin(LISTA); {return new Symbol(simbolo.listas, yychar,yyline,new String(yytext())); }}
"<h1"   {htmltag=htmltag+1;yybegin(HEADLINE); return new Symbol(simbolo.esttxt, yychar,yyline,new String(yytext()));}
"<h2"   {htmltag=htmltag+1;yybegin(HEADLINE); return new Symbol(simbolo.esttxt, yychar,yyline,new String(yytext()));}
"<h3"   {htmltag=htmltag+1;yybegin(HEADLINE); return new Symbol(simbolo.esttxt, yychar,yyline,new String(yytext()));}
"<h4"   {htmltag=htmltag+1;yybegin(HEADLINE); return new Symbol(simbolo.esttxt, yychar,yyline,new String(yytext()));}
"<h5"   {htmltag=htmltag+1;yybegin(HEADLINE); return new Symbol(simbolo.esttxt, yychar,yyline,new String(yytext()));}
"<h6"   {htmltag=htmltag+1;yybegin(HEADLINE); return new Symbol(simbolo.esttxt, yychar,yyline,new String(yytext()));}
"<form" {htmltag=htmltag+1;yybegin(FORM); return new Symbol(simbolo.forms, yychar,yyline,new String(yytext()));}
"<input" {htmltag=htmltag+1;yybegin(FORM); return new Symbol(simbolo.esttxt, yychar,yyline,new String(yytext()));}
"<select>" {htmltag=htmltag+1;yybegin(FORM); return new Symbol(simbolo.esttxt, yychar,yyline,new String(yytext()));}
"<textarea" {htmltag=htmltag+1;yybegin(FORM); return new Symbol(simbolo.esttxt, yychar,yyline,new String(yytext()));}
"<img"    {htmltag=htmltag+1;yybegin(IMGLINK); return new Symbol(simbolo.imglink, yychar,yyline,new String(yytext()));}
"<table" {htmltag=htmltag+1;yybegin(IMGLINK); return new Symbol(simbolo.imglink, yychar,yyline,new String(yytext()));}
">" {htmltag=htmltag+1;yybegin(IMGLINK); return new Symbol(simbolo.imglink, yychar,yyline,new String(yytext()));}
}
<IMGLINK>{
"/>"    {htmltag=htmltag+1;yybegin(YYINITIAL); return new Symbol(simbolo.imglink, yychar,yyline,new String(yytext()));}
">"     {htmltag=htmltag+1; return new Symbol(simbolo.imglink, yychar,yyline,new String(yytext()));}
"<tr>"     {htmltag=htmltag+1; return new Symbol(simbolo.imglink, yychar,yyline,new String(yytext()));}
"<td>"     {htmltag=htmltag+1; return new Symbol(simbolo.imglink, yychar,yyline,new String(yytext()));}
"</td>"     {htmltag=htmltag+1; return new Symbol(simbolo.imglink, yychar,yyline,new String(yytext()));}
"<caption>"     {htmltag=htmltag+1; return new Symbol(simbolo.imglink, yychar,yyline,new String(yytext()));}
"</caption>"     {htmltag=htmltag+1; return new Symbol(simbolo.imglink, yychar,yyline,new String(yytext()));}
"<th>"     {htmltag=htmltag+1; return new Symbol(simbolo.imglink, yychar,yyline,new String(yytext()));}
"</th>"     {htmltag=htmltag+1; return new Symbol(simbolo.imglink, yychar,yyline,new String(yytext()));}
"<font>"     {htmltag=htmltag+1; return new Symbol(simbolo.imglink, yychar,yyline,new String(yytext()));}
"</font>"     {htmltag=htmltag+1; return new Symbol(simbolo.imglink, yychar,yyline,new String(yytext()));}
"</table>"     {htmltag=htmltag+1;yybegin(YYINITIAL); return new Symbol(simbolo.imglink, yychar,yyline,new String(yytext()));}
}
<LISTA>{
"<li>"  {htmltag=htmltag+1;{return new Symbol(simbolo.listas, yychar,yyline,new String(yytext())); }}
"</li>" {htmltag=htmltag+1;{return new Symbol(simbolo.listas, yychar,yyline,new String(yytext())); }}
"<dt>"  {htmltag=htmltag+1;{return new Symbol(simbolo.listas, yychar,yyline,new String(yytext())); }}
"</dt>" {htmltag=htmltag+1;{return new Symbol(simbolo.listas, yychar,yyline,new String(yytext())); }}
"<dd>"  {htmltag=htmltag+1;{return new Symbol(simbolo.listas, yychar,yyline,new String(yytext())); }}
"</dd>" {htmltag=htmltag+1;{return new Symbol(simbolo.listas, yychar,yyline,new String(yytext())); }}
"</ol>" {htmltag=htmltag+1;yybegin(YYINITIAL); {return new Symbol(simbolo.listas, yychar,yyline,new String(yytext())); }}
"</ul>" {htmltag=htmltag+1;yybegin(YYINITIAL); {return new Symbol(simbolo.listas, yychar,yyline,new String(yytext())); }}
"</dl>" {htmltag=htmltag+1;yybegin(YYINITIAL); {return new Symbol(simbolo.listas, yychar,yyline,new String(yytext())); }}
.       {return new Symbol(simbolo.otros, yychar,yyline,new String(yytext()));}
}
<HEADLINE>{
">"             {yybegin(YYINITIAL); return new Symbol(simbolo.esttxt, yychar,yyline,new String(yytext()));}
.               {return new Symbol(simbolo.otros, yychar,yyline,new String(yytext()));}
}
<FORM>{
"<option>"      {htmltag=htmltag+1; return new Symbol(simbolo.forms, yychar,yyline,new String(yytext()));}
"</option"      {htmltag=htmltag+1; return new Symbol(simbolo.forms, yychar,yyline,new String(yytext()));}
"</select>"     {htmltag=htmltag+1;yybegin(FORM); return new Symbol(simbolo.forms, yychar,yyline,new String(yytext()));}
">"             {htmltag=htmltag+1; return new Symbol(simbolo.forms, yychar,yyline,new String(yytext()));}
"</form>"       {htmltag=htmltag+1;yybegin(YYINITIAL); return new Symbol(simbolo.forms, yychar,yyline,new String(yytext()));}
"</textarea>"   {htmltag=htmltag+1;yybegin(YYINITIAL); return new Symbol(simbolo.forms, yychar,yyline,new String(yytext()));}
.               {return new Symbol(simbolo.otros, yychar,yyline,new String(yytext()));}
}
/*otros*/
":"		{return new Symbol(simbolo.esp, yychar,yyline,new String(yytext())); }
";"		{return new Symbol(simbolo.esp, yychar,yyline,new String(yytext())); }
"."             {return new Symbol(simbolo.esp, yychar,yyline,new String(yytext())); }
"{"		{return new Symbol(simbolo.esp, yychar,yyline,new String(yytext())); }
"}"		{return new Symbol(simbolo.esp, yychar,yyline,new String(yytext())); }
","		{return new Symbol(simbolo.esp, yychar,yyline,new String(yytext())); }
"("		{return new Symbol(simbolo.esp, yychar,yyline,new String(yytext())); }
")"		{return new Symbol(simbolo.esp, yychar,yyline,new String(yytext())); }
"["		{return new Symbol(simbolo.esp, yychar,yyline,new String(yytext())); }
"]"		{return new Symbol(simbolo.esp, yychar,yyline,new String(yytext())); }

/*para HTML5*/
/*estructura del documento*/
"<html>"        {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"</html>"       {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"<body>"        {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"<body"        {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"</body>"       {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"<font"        {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"</font>"       {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"size"        {htmltag=htmltag+1;return new Symbol(simbolo.add, yychar,yyline,new String(yytext()));}
""background-color""        {htmltag=htmltag+1;return new Symbol(simbolo.add, yychar,yyline,new String(yytext()));}
"style"   {htmltag=htmltag+1;yybegin(HEADLINE); return new Symbol(simbolo.esttxt, yychar,yyline,new String(yytext()));}
"<head>"        {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"</head>"       {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"<title>"       {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"</title>"      {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"<body>"        {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"</body>"       {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"<section>"       {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"</section>"       {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"<nav>"       {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"</nav>"       {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"<article> "       {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"</article>"       {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"<aside>"       {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"</aside>"       {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"<header>"       {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"</header>"       {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"<footer>"       {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"</footer>"       {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"<main>"       {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"</main>"       {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"<figure>"       {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"</figure>"       {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"<figcaption>"       {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"</figcaption>"       {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"<data>"       {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"</data>"       {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"<time>"       {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"</time>"       {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"<time>"       {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"</time>"       {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"<mark>"       {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"</mark>"       {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"<ruby>"       {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"</ruby>"       {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"<rt>"       {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"</rt>"       {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"<rp>"       {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"</rp>"       {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"<bdi>"       {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"</bdi>"       {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"<wbr>"       {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"</wbr>"       {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"<video>"       {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"</video>"       {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"<audio>"       {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"</audio>"       {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"<source>"       {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"</source>"       {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"<track>"       {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"</track>"       {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"<canvas>"       {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"</canvas>"       {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"<svg>"       {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"</svg>"       {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"<math>"       {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"</math>"       {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"<datalist>"       {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"</datalist>"       {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"<keygen>"       {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"</keygen>"       {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"<output>"       {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"</output>"       {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"<progress>"       {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"</progress>"       {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"<meter>"       {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"</meter>"       {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"<details>"       {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"</details>"       {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"<summary>"       {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"</summary>"       {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"<command>"       {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"</command>"       {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"<menu>"       {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"</menu>"       {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"<!DOCTYPE"       {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"<a"       {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"</a"       {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"href"       {htmltag=htmltag+1;return new Symbol(simbolo.add, yychar,yyline,new String(yytext()));}
"<abbr>"       {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"</abbr>"       {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"title"       {htmltag=htmltag+1;return new Symbol(simbolo.add, yychar,yyline,new String(yytext()));}
"</abbr>"       {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"<address>"    {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"</address>"    {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"<area"   {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"</area>"   {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"<base"   {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"<bdo>"  {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"</bdo>"  {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"<button>" {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"</button>" {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"name"       {htmltag=htmltag+1;return new Symbol(simbolo.add, yychar,yyline,new String(yytext()));}
"<cite>"  {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"</cite>"  {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"<code>"  {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"</code>"  {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"<col"   {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"<colgroup>" {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"</colgroup>" {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"span"        {htmltag=htmltag+1;return new Symbol(simbolo.add, yychar,yyline,new String(yytext()));}
"<del>"   {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"</del>"   {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"<dfn>"  {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"</dfn>"  {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"<dialog>"  {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"</dialog>"  {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"<em>"  {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"</em>"  {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"<embed" {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"<fieldset>"  {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"</fieldset>"  {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"<form"    {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"<hgroup>"  {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"</hgroup>"  {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"<iframe>" {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"</iframe>" {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"<img"  {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"src"       {htmltag=htmltag+1;return new Symbol(simbolo.add, yychar,yyline,new String(yytext()));}
"<input"   {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"<ins>"    {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"</ins>"    {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"<kbd>"   {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));} 
"</kbd>"   {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));} 
"<label>"  {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));} 
"</label>"  {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));} 
"<legend>" {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"</legend>" {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"<link" {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"<map"  {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"<meta" {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"<noscript>" {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"</noscript>" {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"<objet"  {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"data"       {htmltag=htmltag+1;return new Symbol(simbolo.add, yychar,yyline,new String(yytext()));}
"<optgroup>" {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"</optgroup>" {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"<param" {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"<q>" {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"</q>" {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"<samp>" {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"</samp>" {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"<script" {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"</script>" {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"<span>" {htmltag=htmltag+1;return new Symbol(simbolo.nume, yychar,yyline,new String(yytext()));}
"</span>" {htmltag=htmltag+1;return new Symbol(simbolo.nume, yychar,yyline,new String(yytext()));}
"<strong>" {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));} 
"</strong>" {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));} 
"<style>" {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));} 
"</style>" {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));} 
"<sup>" {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"<sup>" {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"</sup>" {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"<tbody>" {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"</tbody>" {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"<textarea>" {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"</textarea>" {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"<tfoot>" {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"</tfoot>" {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"<thead>" {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"</thead>" {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"<var>" {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"</var>" {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}
"<tr>" {htmltag=htmltag+1;return new Symbol(simbolo.imglink, yychar,yyline,new String(yytext()));}
"</tr>" {htmltag=htmltag+1;return new Symbol(simbolo.imglink, yychar,yyline,new String(yytext()));}

">"       {htmltag=htmltag+1;return new Symbol(simbolo.estdoc, yychar,yyline,new String(yytext()));}


/*estructuras al texto*/
"<p>"           {htmltag=htmltag+1;return new Symbol(simbolo.esttxt, yychar,yyline,new String(yytext()));}
"</p>"          {htmltag=htmltag+1;return new Symbol(simbolo.esttxt, yychar,yyline,new String(yytext()));}
"<div>"         {htmltag=htmltag+1;return new Symbol(simbolo.esttxt, yychar,yyline,new String(yytext()));}
"</div>"        {htmltag=htmltag+1;return new Symbol(simbolo.esttxt, yychar,yyline,new String(yytext()));}
"<hr>"          {htmltag=htmltag+1;return new Symbol(simbolo.esttxt, yychar,yyline,new String(yytext()));}
"</hr>"         {htmltag=htmltag+1;return new Symbol(simbolo.esttxt, yychar,yyline,new String(yytext()));}
"<Blockquote>"  {htmltag=htmltag+1;return new Symbol(simbolo.esttxt, yychar,yyline,new String(yytext()));}
"</Blockquote>" {htmltag=htmltag+1;return new Symbol(simbolo.esttxt, yychar,yyline,new String(yytext()));}
"<pre>"         {htmltag=htmltag+1;return new Symbol(simbolo.esttxt, yychar,yyline,new String(yytext()));}
"</pre>"        {htmltag=htmltag+1;return new Symbol(simbolo.esttxt, yychar,yyline,new String(yytext()));}
/*formato al texto*/
"<br>"           {htmltag=htmltag+1;return new Symbol(simbolo.txtformat, yychar,yyline,new String(yytext()));}
"</br>"           {htmltag=htmltag+1;return new Symbol(simbolo.txtformat, yychar,yyline,new String(yytext()));}
"<b>"           {htmltag=htmltag+1;return new Symbol(simbolo.txtformat, yychar,yyline,new String(yytext()));}
"</b>"          {htmltag=htmltag+1;return new Symbol(simbolo.txtformat, yychar,yyline,new String(yytext()));}
"<i>"           {htmltag=htmltag+1;return new Symbol(simbolo.txtformat, yychar,yyline,new String(yytext()));}
"</i>"          {htmltag=htmltag+1;return new Symbol(simbolo.txtformat, yychar,yyline,new String(yytext()));}
"<u>"           {htmltag=htmltag+1;return new Symbol(simbolo.txtformat, yychar,yyline,new String(yytext()));}
"</u>"          {htmltag=htmltag+1;return new Symbol(simbolo.txtformat, yychar,yyline,new String(yytext()));}
"<tt>"          {htmltag=htmltag+1;return new Symbol(simbolo.txtformat, yychar,yyline,new String(yytext()));}
"</tt>"         {htmltag=htmltag+1;return new Symbol(simbolo.txtformat, yychar,yyline,new String(yytext()));}
"<sub>"         {htmltag=htmltag+1;return new Symbol(simbolo.txtformat, yychar,yyline,new String(yytext()));}
"</sub>"        {htmltag=htmltag+1;return new Symbol(simbolo.txtformat, yychar,yyline,new String(yytext()));}
"<big>"         {htmltag=htmltag+1;return new Symbol(simbolo.txtformat, yychar,yyline,new String(yytext()));}
"</big>"        {htmltag=htmltag+1;return new Symbol(simbolo.txtformat, yychar,yyline,new String(yytext()));}
"<small>"       {htmltag=htmltag+1;return new Symbol(simbolo.txtformat, yychar,yyline,new String(yytext()));}
"</small>"      {htmltag=htmltag+1;return new Symbol(simbolo.txtformat, yychar,yyline,new String(yytext()));}
"<blink>"       {htmltag=htmltag+1;return new Symbol(simbolo.txtformat, yychar,yyline,new String(yytext()));}
"</blink>"      {htmltag=htmltag+1;return new Symbol(simbolo.txtformat, yychar,yyline,new String(yytext()));}
"<s>"           {htmltag=htmltag+1;return new Symbol(simbolo.txtformat, yychar,yyline,new String(yytext()));}
"</s>"          {htmltag=htmltag+1;return new Symbol(simbolo.txtformat, yychar,yyline,new String(yytext()));}
/*otras cosas del html*/
{htmlcomment}   {htmlcom=htmlcom+1; return new Symbol(simbolo.htmlcomment, yychar,yyline,new String(yytext()));}
[ \t\r\f\n]+    {return new Symbol(simbolo.finalesydemas, yychar,yyline,new String(yytext()));}
"</h1>"         {htmltag=htmltag+1;yybegin(YYINITIAL); return new Symbol(simbolo.esttxt, yychar,yyline,new String(yytext()));}
"</h2>"         {htmltag=htmltag+1;yybegin(YYINITIAL); return new Symbol(simbolo.esttxt, yychar,yyline,new String(yytext()));}
"</h3>"         {htmltag=htmltag+1;yybegin(YYINITIAL); return new Symbol(simbolo.esttxt, yychar,yyline,new String(yytext()));}
"</h4>"         {htmltag=htmltag+1;yybegin(YYINITIAL); return new Symbol(simbolo.esttxt, yychar,yyline,new String(yytext()));}
"</h5>"         {htmltag=htmltag+1;yybegin(YYINITIAL); return new Symbol(simbolo.esttxt, yychar,yyline,new String(yytext()));}
"</h6>"         {htmltag=htmltag+1;yybegin(YYINITIAL); return new Symbol(simbolo.esttxt, yychar,yyline,new String(yytext()));}
.               {return new Symbol(simbolo.otros, yychar,yyline,new String(yytext()));}
