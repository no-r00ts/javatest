
use rokagym_db;
drop PROCEDURE if exists rokagym_db.proc_formulario_mante_get;
create PROCEDURE rokagym_db.proc_formulario_mante_get(in p_tabla VARCHAR(50))  
BEGIN
/*creamos la cabecera*/

select CONCAT("<%-- ",CHAR(10),
"*Nombre Archivo : ",p_tabla,"_mante.jsp",CHAR(10), 
"*Creador Archivo: ",@@hostname ,CHAR(10),
"*Fecha Creacion : ",now() ,CHAR(10),
"--%>",char(10),char(10)) 
union all 
 

select CONCAT(" 


<script src='complementos/js/jquery-3.2.1.min.js' type='text/javascript'></script>
<script src='complementos/js/principal.js' type='text/javascript'></script>
<% " ,char(10)) 
union ALL



select concat("String ", column_name ,"="""";","
if (request.getParameter(""",column_name,""" ) != null) { ","
		",column_name," = request.getParameter(""",column_name,""").toString();
}"
)
from information_schema.COLUMNS where TABLE_SCHEMA = 'rokagym_db'  and  table_name = p_tabla

union all 

select CONCAT(
" 
%> 
<script>
    limite = 8;

    function guardar() {  
       if( $('#txtEstado').prop('checked') ) 
        estado=1; 

var parametros = {",(select GROUP_CONCAT( CONCAT( char(10),
											"txt",CONCAT(UCASE(LEFT(COLUMN_NAME, 1)),LCASE(SUBSTRING(COLUMN_NAME, 2))),": $(""#txt",CONCAT(UCASE(LEFT(COLUMN_NAME, 1)),LCASE(SUBSTRING(COLUMN_NAME, 2))),""").val()" ))  
from information_schema.COLUMNS where TABLE_SCHEMA = 'rokagym_db'  and  table_name = p_tabla)
,"
       };  
        $.ajax({
            url: '",p_tabla,"_tabla.htm',
            type: 'POST', 
            data: parametros,
            success: function (data) { 
            console.log(data);
            document.getElementById(""mensaje"").innerHTML = data.mensaje;
            }
        });
    }
     
    
</script>
" 
)
union all  
select CONCAT(" 
        <div>
            <div class='container'>     
									<div class='form-control'>
											<div class='row'>  
													<div class='col-10'> 
															<h3>Mantenimiento <small>",p_tabla,"</small></h3>
													</div>
													 
											</div>    
									</div>
									<div class='row'>
											<div class='col-md-2'>&nbsp;<br></div>
											<div class='col-md-10'>
                        <form class='form-horizontal' action=",p_tabla,".htm role='form' method='post'>  <br>
",char(10))

union all  
    

select CONCAT( "			    <div class='form-group'>
														<div class='row'>
															<div class='col-sm-2'>
                                <label for='txt",CONCAT(UCASE(LEFT(COLUMN_NAME, 1)),LCASE(SUBSTRING(COLUMN_NAME, 2))),"' class='col-sm-2 control-label'>",
																					CONCAT(UCASE(LEFT(COLUMN_NAME, 1)),LCASE(SUBSTRING(COLUMN_NAME, 2))),"</label>
                                <div class='col-sm-10'>
                                    <input type='text' value = '<%=",COLUMN_NAME,"%>' class='form-control' id='txt",CONCAT(UCASE(LEFT(COLUMN_NAME, 1)),LCASE(SUBSTRING(COLUMN_NAME, 2))),"' 
 name ='txt",CONCAT(UCASE(LEFT(COLUMN_NAME, 1)),LCASE(SUBSTRING(COLUMN_NAME, 2))),"' placeholder='",COLUMN_NAME,"'>
                                </div>
                            </div>
													</div>
												</div>")
from information_schema.COLUMNS 
where TABLE_SCHEMA = 'rokagym_db' AND table_name = p_tabla
 union all
 
select CONCAT("

                        <div class='form-group'>

                            <p id = 'mensaje' class=""text-center text-danger""> </p>

                            <div class='col-sm-offset-2 col-sm-10'>
                                <button type='submit' onclick=""guardar();return false"" class='btn btn-default alert-primary'>Grabar</button>
                                <a class='btn btn-default alert-primary' href=""inicio.htm?page=",p_tabla,"_lista&titulo=",p_tabla,""" >Regresar</a>
                            </div>
                        </div>
										</form>
                    </div>
                </div>
            </div>   
        </div> "
,char(10)) ;
         
END;
call rokagym_db.proc_formulario_mante_get('cliente');
/*Mantenimiento*/