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
                        type : '0',
                        name : 'xnoa',
                        value : ''
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
                
                if(r_outs==1){
                	$('#txtXcust1a').val(r_userno).attr('disabled','disabled');
                	$('#txtXcust1b').val(r_name).attr('disabled','disabled');
                	$('#txtXcust2a').val(r_userno).attr('disabled','disabled');
                	$('#txtXcust2b').val(r_name).attr('disabled','disabled');
                	$('#btnXcust1').hide();
                	$('#btnXcust2').hide();
                }
                $('#txtXnoa').attr('disabled','disabled');
                $('#txtBnoa').attr('disabled','disabled');
                $('#txtEnoa').attr('disabled','disabled');
                $('#txtBnoa').mask('9999999999');
                $('#txtEnoa').mask('9999999999');
                $('#txtXdate').mask('999/99/99');
	            $('#txtXdate').val(q_date())
                $('.prt').hide();
                
                //顯示上傳紀錄(顯示前10筆)
                if(r_outs==1)
                	t_where="where=^^1=1 and custno='"+r_userno+"' order by datea desc,custno^^ top=10";
                else
                	t_where="where=^^1=1  order by datea desc,custno^^ top=10";
				q_gt('view_vcc_bv', t_where, 0, 0, 0,'', r_accy);
                
                
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
                			if(Math.abs(q_sub(dec($('#txtBnoa').val().substr(-8).substr(0,7)),dec($('#txtEnoa').val().substr(-8).substr(0,7))))<300){
                				window.open("./pdf_edi.aspx?bno="+$('#txtBnoa').val()+"&eno="+$('#txtEnoa').val()+"&str="+$('#Str .cmb').val()+"&db="+q_db);
                				$('.vcc_chk').each(function(index) {
									var n=$(this).attr('id').replace('vcc_chk','')
									$('#vcc_chk'+n).prop('checked',false).attr('disabled','disabled');
									$('#vcc_print'+n).text('已列印');
								});
                			}else
                				alert('條碼範圍不得超逾300張!!!');
                		}else{
                			alert('請輸入正確的97條碼!!!');
                		}
                	}else{
                		//alert('請輸入97條碼!!!');
                		alert('請選擇上傳紀錄!!!');
                	}
                	
				});
				
				/*var t_para = new Array();
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
	            }*/
	            
	            $('#btnAuthority').click(function(e) {
					btnAuthority(q_name);
				});
				
				$('#qReport').click(function(){
					if($('#qReport').data('info').radioIndex==0){
						$('.prt').hide();
						$('.vcc').show();
						$('.download').show();
					}else{
						$('.prt').show();
						$('.vcc').hide();
						$('.download').hide();
					}
				});
				$('#btnOk').hide();
				if(window.parent.q_name == 'transef_edi_bv'){
					var delete_report=0;
					for(var i=0;i<$('#qReport').data().info.reportData.length;i++){
						if($('#qReport').data().info.reportData[i].report=='z_transef_bv01')
							delete_report=i;
					}
					if($('#qReport div div').text().indexOf('EDI託運單')>-1)
						$('#qReport div div').eq(delete_report).remove();
					
					$('#qReport div div .radio').last().removeClass('nonselect').addClass('select').click();
					if(q_getHref()[1]!=undefined || q_getHref()[1]!=''){
						$('#qReport').data().info.options[0].value=q_getHref()[1];
						t_where="where=^^noa='"+q_getHref()[1]+"' order by datea desc,custno^^";
						q_gt('view_vcc_bv', t_where, 0, 0, 0,'getisprint', r_accy);
					}
				}else{
					var delete_report=0;
					for(var i=0;i<$('#qReport').data().info.reportData.length;i++){
						if($('#qReport').data().info.reportData[i].report=='z_transef_bv02')
							delete_report=i;
					}
					if($('#qReport div div').text().indexOf('託運總表')>-1)
						$('#qReport div div').eq(delete_report).remove();
				}
            }

            function q_boxClose(t_name) {
            	
            }

            function q_gtPost(t_name) {
            	switch (t_name) {
            		case 'getisprint':
            			var as = _q_appendData("view_vcc", "", true);
                        if (as[0] != undefined){
                        	if(as[0].isprint==''){
                        		alert('託運單尚未列印!!')
                        	}else{
                        		$('#btnOk').click();
                        		var wParent = window.parent.document;
								wParent.getElementById("vcc_ordeno"+q_getHref()[3]).innerHTML = '已列印';
                        	}
                        }else{
                        	alert('資料錯誤!!!')
                        }
            			break;
            		case 'view_vcc_bv':
            			var as = _q_appendData("view_vcc", "", true);
                        if (as[0] != undefined){
                        	//產生報表
                        	var string = "<BR><table id='vcc_table' style='width:450px;'>";
                        	string+='<tr id="vcc_top"><td colspan="7" style="text-align:left;">上傳紀錄</td></tr>';
		                    string+='<tr id="vcc_header">';
		                    string+='<td id="vcc_chk" align="center" style="width:20px; color:black;">選</td>';
		                    string+='<td id="vcc_noa" style="display:none;">上傳編號</td>';
		                    string+='<td id="vcc_datea" align="center" style="width:80px; color:black;">上傳日期</td>';
		                    string+='<td id="vcc_datea" align="center" style="width:80px; color:black;">時間</td>';
		                    string+='<td id="vcc_memo" align="center" style="width:120px; color:black;">上傳檔案</td>';
		                    string+='<td id="vcc_mount" align="center" style="width:50px; color:black;">筆數</td>';
		                    string+='<td id="vcc_print" align="center" style="width:80px; color:black;">托運單</td>';
		                    string+='</tr>';
		                    
		                    var t_color = ['DarkBlue','DarkRed'];
		                    for(var i=0;i<as.length;i++){
		                        string+='<tr id="vcc_tr'+i+'">';
		                        if (as[i].isprint=='已列印')
		                        	string+='<td style="text-align: center;"><input id="vcc_chk'+i+'" class="vcc_chk" type="checkbox" disabled="disabled"/></td>';
		                        else
		                        	string+='<td style="text-align: center;"><input id="vcc_chk'+i+'" class="vcc_chk" type="checkbox"/></td>';
		                        string+='<td id="vcc_noa'+i+'" style="display:none;color:'+t_color[i%t_color.length]+'">'+as[i].noa+'</td>';
		                        string+='<td id="vcc_datea'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+'">'+as[i].datea+'</td>';
		                        string+='<td id="vcc_mon'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+'">'+as[i].mon+'</td>';
		                        string+='<td id="vcc_memo'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+'">'+as[i].memo+'</td>';
		                        string+='<td id="vcc_mount'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+'">'+as[i].mount+'</td>';
		                        string+='<td id="vcc_print'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+'">'+as[i].isprint+'</td>';
		                        string+='</tr>';
		                    }
		                    string+='</table>';
		                    
		                    $('.vcc').append(string);
		                    
		                    $('.vcc_chk').click(function(e) {
		                        $(".vcc_chk").not(this).prop('checked', false);
		                        $(".vcc_chk").not(this).parent().parent().find('td').css('background', 'aliceblue');
		                        $(this).prop('checked', true);
		                        $(this).parent().parent().find('td').css('background', 'antiquewhite');
		                        
		                        //顯示BBS的資料
		                        var n=$(this).attr('id').replace('vcc_chk','')
		                        vcc_n=n;
		                        var t_where="where=^^treno='"+$('#vcc_noa'+n).text()+"' ^^";
								q_gt('view_transef', t_where, 0, 0, 0,'get_transef', r_accy);
		                    });
                        }else{
                        	var string = "<BR><table id='vcc_table' style='width:450px;'>";
                        	string+='<tr id="vcc_top"><td colspan="7" style="text-align:left;">無上傳紀錄</td></tr>';
		                    string+='</table>';
		                    $('.vcc').append(string);
                        }
            			break;
            		case 'get_transef':
            			var as = _q_appendData("view_transef", "", true);
            			if (as[0] != undefined){
            				as.sort(compare);
	            			var t_bnoa=as[0].boatname;
		                	var t_enoa=as[(as.length-1)].boatname;
		                	if(t_bnoa>t_enoa){
		                		var tmp=t_bnoa;
		                		t_bnoa=t_enoa;
		                		t_enoa=tmp;
		                	}
		                	$('#txtBnoa').val(t_bnoa);
		                	$('#txtEnoa').val(t_enoa);
		                }else{
		                	$('#txtBnoa').val('');
		                	$('#txtEnoa').val('');
		                }
            			break;
            	}
            }
            
            function compare(a,b) {
				if (a.boatname+a.po+a.so< b.boatname+b.po+b.so)
					return -1;
				if (a.boatname+a.po+a.so > b.boatname+b.po+b.so)
					return 1;
				return 0;
			}
            
		</script>
		<style type="text/css">
			#vcc_table {
                border: 5px solid gray;
                font-size: medium;
                background-color: white;
            }
            #vcc_table tr {
                height: 30px;
            }
            #vcc_table td {
                padding: 2px;
                text-align: center;
                border-width: 0px;
                background-color: aliceblue;
                color: blue;
            }
		</style>
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
			<div class="vcc" style="float: left; width: 100%;"> </div>
			<div class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>