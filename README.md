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
          style="color: #999999;"> <font size="+2">version 9.8 for Kawa Scheme<br>
          </font></span></b></h1>
    <p style="text-align: center;">
	The general documentation of Scheme+ is available here:<br>
  <br>
    <a
  href="https://github.com/damien-mattei/Scheme-PLUS-for-Guile/blob/main/README.md">Scheme+
  general documentation.</a>
  <br>
  <br>
  <b>Changes of version 9.8:</b> Parser accept nested commented expression with #;<br>
  <br>
  <br>
  <b>Changes of version 9.7:</b> now Scheme+ can be compiled in java/jakarta classes<br>
  <br>
  Support for Jakarta<br><br>
  Compile it with : <b>kawa -C Scheme+.scm</b><br><br>
  Fixes Kawa "bug" about syntax transformers not importing definitions at early phase in macro extansion (use <a
  href="https://www.gnu.org/software/kawa/Definitions.html#idm45230723208176">define-early-constant</a> in code).The problem was only existing when compiled in classes,not in REPL strangely.(note that classes can occurs java out of memory error on very intensive computations taking hours,which is happening in REPL strangely at end of computation , another Kawa bug i presume or require some special options perheaps in compilation)
  <br>
  <br>
  Specific documentation for Kawa Scheme:
  <br>
  <br>
  For SRFI 105 support in Scheme+ you must preprocess your Kawa
  Scheme+ code with one of  those commands:<br>
  <br>
  <pre>
  curly-infix2prefix4kawa.scm --kawa your_kawa_file_in_scheme+.scm | tr -d '|' > your_kawa_file_in_scheme.scm
  </pre>
  <br>
  <pre>
  kawa curly-infix2prefix4kawa.scm --kawa your_kawa_file_in_scheme+.scm | tr -d '|' > your_kawa_file_in_scheme.scm
  </pre>
  
  for Scheme+ (with less compatibility with Kawa: <: not allowed in
  vectors) you can remove the --kawa option above or use the command below:
  <pre>
  scheme+2kawa your_kawa_file_in_scheme+.scm
</pre>
<br>
<br>
    <a
  href="https://github.com/damien-mattei/Scheme-PLUS-for-Kawa/blob/main/examples/exo_retropropagationNhidden_layers_matrix_v2_by_vectors4kawa%2B.scm">Example
  of Scheme+ code for Kawa.</a>
  <br>
  <br>
   <a
  href="https://github.com/damien-mattei/Scheme-PLUS-for-Kawa/blob/main/examples/matrix%2B.scm">Another
   example
  of Scheme+ code implementing Matrix and multiplication.</a>
  <br>
  <br>
  
  <a
  href="https://github.com/damien-mattei/Scheme-PLUS-for-Kawa/blob/main/examples/Makefile">Example
  of a Makefile for Scheme+ code building the above examples.</a>

  <br>
  
  </body>

