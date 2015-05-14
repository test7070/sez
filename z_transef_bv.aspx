<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
            $(document).ready(function() {
                _q_boxClose();
                q_getId();
                q_gf('', 'z_transef_bv');
            });
            function q_gfPost() {
                $('#qReport').q_report({
                    fileName : 'z_transef_bv',
                    options : [{
                        type : '6',
                        name : 'xdate'
                    }, {
                        type : '2',
                        name : 'xcust',
                        dbf : 'cust',
                        index : 'noa,comp',
                        src : 'cust_b.aspx'
                    },{
                        type : '6',
                        name : 'bnoa'
                    }, {
                        type : '6',
                        name : 'enoa'
                    }, {
                        type : '5', 
                        name : 'str',
                        value : new Array("0@1","1@2","2@3","3@4","4@5","5@6")
                    },{
                        type : '0',
                        name : 'path',
                        value : location.href.toLowerCase().replace(/(.*)(z_transef_bv.aspx)(.*)/g,'$1')
                    }]
                });
                q_getFormat();
                q_langShow();
                q_popAssign();
                document.title='4.3 EDI託運單列印'
                
                $('#txtBnoa').mask('9999999999');
                $('#txtEnoa').mask('9999999999');
                $('#txtXdate').mask('999/99/99');
	            $('#txtXdate').val(q_date())
	            
                $('.prt').hide();
                
                $('#txtBnoa').change(function() {
                	if(!emp($(this).val())){
                		if(!((/^97[0-9]{8}$/g).test($(this).val()) && dec($(this).val().substr(0,9))%7 == dec($(this).val().substr(-1))))
                			alert('請輸入正確的97條碼!!!');
                	}
				});
				
				$('#txtEnoa').change(function() {
                	if(!emp($(this).val())){
                		if(!((/^97[0-9]{8}$/g).test($(this).val()) && dec($(this).val().substr(0,9))%7 == dec($(this).val().substr(-1))))
                			alert('請輸入正確的97條碼!!!');
                	}
				});
                
                $('#btnDownloadPdf').click(function() {
                	if(!emp($('#txtBnoa').val())&&!emp($('#txtEnoa').val())){
                		if((/^97[0-9]{8}$/g).test($('#txtBnoa').val()) && (/^97[0-9]{8}$/g).test($('#txtEnoa').val())
                		&& dec($('#txtBnoa').val().substr(0,9))%7 == dec($('#txtBnoa').val().substr(-1))
                		&& dec($('#txtEnoa').val().substr(0,9))%7 == dec($('#txtEnoa').val().substr(-1))
                		){
                			if(Math.abs(q_sub(dec($('#txtBnoa').val().substr(-8).substr(0,7)),dec($('#txtEnoa').val().substr(-8).substr(0,7))))<300)
                				window.open("./pdf_edi.aspx?bno="+$('#txtBnoa').val()+"&eno="+$('#txtEnoa').val()+"&str="+$('#Str .cmb').val()+"&db="+q_db);
                			else
                				alert('條碼範圍不得超逾300張!!!');
                		}else{
                			alert('請輸入正確的97條碼!!!');
                		}
                	}else{
                		alert('請輸入97條碼!!!');
                	}
                	
				});
				
				
				var t_para = new Array();
	            try{
	            	t_para = JSON.parse(q_getId()[3]);
	            }catch(e){
	            }    
	            if(t_para.length==0 || t_para.bnoa==undefined || t_para.enoa==undefined){
	            	
	            }else{
	            	$('#txtBnoa').val(t_para.bnoa);
                	$('#txtEnoa').val(t_para.enoa);
                	if(!emp($('#txtBnoa').val()) && !emp($('#txtEnoa').val()))
                		$('#btnDownloadPdf').click();
	            }
	            
	            $('#btnAuthority').click(function(e) {
					btnAuthority(q_name);
				});
				
				$('#qReport').click(function(){
					if($('#qReport').data('info').radioIndex==2){
						$('.prt').hide();
						$('.download').show();
					}else{
						$('.prt').show();
						$('.download').hide();
					}
				});
            }

            function q_boxClose(t_name) {
            }

            function q_gtPost(t_name) {
            }
		</script>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
		<div id="q_menu"> </div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;width:2000px;">
			<div id="container">
				<div id="qReport"> </div>
			</div>
			<div class="download" style="float: left; width: 100%;">
				<input class="btn" id="btnDownloadPdf" type="button" value='列印' style=" font-weight: bold;font-size: 16px;color: blue;" />
				<input class="btn" id="btnAuthority" type="button" value="權限" style=" font-weight: bold;font-size: 16px;color: blue;"/>
			</div>
			<div class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>