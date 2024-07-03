<body>
  <p>
      <br>
  </p>
  <div align="center">
    <br>
  </div>
  <div align="center"><img moz-do-not-send="true" src="Scheme+io_fichiers/Scheme+.png" title="by Damien MATTEI"
        alt="Scheme+" width="290" height="65"></div>
    <h2 style="text-align: center;"><span style="color: #00cccc;"><i>Enhancing
          Scheme (and Lisp-like) language. </i></span></h2>
    <h2 style=" text-align: center;">Damien Mattei<br>
    </h2>
    <p style="text-align: center;"><i><br>
      </i></p>
    <p style="text-align: center;"><i>"Doubts are such tiny things. A mind with
        no room for doubts must have no room for thoughts either."</i> -<a href="https://www.ics.uci.edu/%7Epattis/"
        target="_blank">R. Patti</a></p>
    <p style="text-align: center;"><br>
    </p>
    <h1 style="text-align: center;"><b><span style="color: #000099;">Scheme+</span></b><b><span
          style="color: #999999;"> <font size="+2">version 9.1 for Kawa Scheme<br>
          </font></span></b></h1>
    <p style="text-align: center;">
	The general documentation of Scheme+ is available here:<br>
  <br>
    <a
  href="https://github.com/damien-mattei/Scheme-PLUS-for-Guile/blob/main/README.md">Scheme+
  general documentation.</a>
  <br>
  <br>
  Specific documentation for Kawa Scheme:
  <br>
  <br>
  For SRFI 105 support in Scheme+ you must preprocess your Kawa
  Scheme+ code with one of  those commands:<br>
  <br>
  <pre>
  kawa curly-infix2prefix4kawa.scm --srfi-105 your_kawa_file_in_scheme+.scm | tr -d '|' > your_kawa_file_in_scheme.scm
  </pre>
  
  for Scheme+ (with less compatibility with Kawa: <: not allowed in
  vectors) you can use the command:
  <pre>
  scheme+2kawa your_kawa_file_in_scheme+.scm
</pre>
<br>
<br>
    <a
  href="https://github.com/damien-mattei/AI_Deep_Learning/blob/main/exo_retropropagationNhidden_layers_matrix_v2_by_vectors4kawa%2B.scm">Example
  of Scheme+ code for Kawa.</a>
  <br>
  <br>
   <a
  href="https://github.com/damien-mattei/AI_Deep_Learning/blob/main/kawa/matrix%2B.scm">Another
   example
  of Scheme+ code implementing Matrix and multiplication.</a>
  
  <a
  href="https://github.com/damien-mattei/AI_Deep_Learning/blob/main/Makefile.Kawa">Example
  of a Makefile for Scheme+ code building the above examples.</a>

  <br>
  </body>


