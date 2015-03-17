<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"> </script>
		<script src='../script/qj2.js' type="text/javascript"> </script>
		<script src='qset.js' type="text/javascript"> </script>
		<script src='../script/qj_mess.js' type="text/javascript"> </script>
		<script src="../script/qbox.js" type="text/javascript"> </script>
		<script src='../script/mask.js' type="text/javascript"> </script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"> </script>
		<script src="css/jquery/ui/jquery.ui.widget.js"> </script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"> </script>
		<script type="text/javascript">
		
		var isorda=true; //選擇要產生orde還是orda 要產生orda=ture,要產生orde=false
            $(document).ready(function() {
                _q_boxClose();
                q_getId();
                q_gf('', 'z_workg2ordb');
                
                $('#q_report').click(function(e) {
										
					for(var i =0 ;i<$('#q_report').data().info.reportData.length;i++){
						if($('.radio.select').next().text()==$('#q_report').data().info.reportData[i].reportName){
							//下面註解取得q_lang的z_xxxxx
							var txtreport=$('#q_report').data().info.reportData[i].report;
						}
					}
										
					if(txtreport=='z_workg2ordb1'){
						/*if(isorda){
							$('#btnOrdb').hide();
							$('#btnOrda').show();
							$('#btnOrda2ordb').hide();
						}else{
							$('#btnOrdb').show();
							$('#btnOrda').hide();
							$('#btnOrda2ordb').hide();
						}
					}else{
						$('#btnOrdb').hide();
						$('#btnOrda').hide();
						if(isorda){
							$('#btnOrda2ordb').show();
						}else{
							$('#btnOrda2ordb').hide();
						}*/
					}
				});
            });
            function q_gfPost() {
                $('#q_report').q_report({
                    fileName : 'z_workg2ordb',
                    options : [{
						type : '0',
						name : 'accy',
                        value : q_getId()[4] //[1]
                    },{
                        type : '1', //[2][3]
                        name : 'odate'
                    },{
                        type : '1', //[4][5]
                        name : 'workgno'
                    },{
                        type : '2',//[6][7]
                        name : 'xproductno',
                        dbf : 'ucc',
                        index : 'noa,product',
                        src : 'ucc_b.aspx'
                     },{
                        type : '8', //[10]>>[8]
                        name : 'otherworkg',
                        value : ("1@包含其他排產製令(製令未領)").split(',')
                    },{
                        type : '1', //[9]>>[9][10]
                        name : 'enddate' //原(應完工截止日)>>改其他排產製令區間
                    },{
                        type : '8', //[11]
                        name : 'xordc',
                        value : ("1@包含在途量").split(',')
                    },{
                        type : '8', //[12]
                        name : 'xsafe',
                        value : ("1@包含安全存量").split(',')
                    },{
                        type : '8', //[13]
                        name : 'xstore',
                        value : ("1@包含庫存").split(',')
                    },{
                        type : '8', //[8]>>[13]>>[14]
                        name : 'workgall',
                        value : ("1@全部未請購的排產計畫").split(',')
                    }]
                });
                q_popAssign();
                q_getFormat();
                q_langShow();
                
                $('#txtOdate1').mask('999/99/99');
                $('#txtOdate1').datepicker();
                $('#txtOdate2').mask('999/99/99');
                $('#txtOdate2').datepicker();
                $('#txtEnddate1').mask('999/99/99');
                $('#txtEnddate1').datepicker();
                $('#txtEnddate1').val(q_cdn(q_date(),-60));
                $('#txtEnddate2').mask('999/99/99');
                $('#txtEnddate2').datepicker();
                $('#txtEnddate2').val(q_date());
                
                var btn = document.getElementById('btnOk');
                	btn.insertAdjacentHTML("afterEnd","<input type='button' id='btnOrdb' style='font-size: 16px; font-weight: bold; color: blue; cursor: pointer;' value='無簽核轉請購'>");
                	btn.insertAdjacentHTML("afterEnd","<input type='button' id='btnOrda2ordb' style='font-size: 16px; font-weight: bold; color: blue; cursor: pointer;' value='簽核轉請購'>");
                	btn.insertAdjacentHTML("afterEnd","<input type='button' id='btnOrdabox' style='font-size: 16px; font-weight: bold; color: blue; cursor: pointer;' value='簽核明細'>");
                	btn.insertAdjacentHTML("afterEnd","<input type='button' id='btnOrda' style='font-size: 16px; font-weight: bold; color: blue; cursor: pointer;' value='送簽核'>");
                	btn.insertAdjacentHTML("afterEnd","<input type='button' id='btnCheck' style='font-size: 16px; font-weight: bold; color: blue; cursor: pointer;' value='查詢'>");
                	
                //0626 該功能先關閉---避免有問題
                $('#chkWorkgall [type]=checkbox').attr('disabled', 'disabled');
                
                if (window.parent.q_name == 'workg') {
					var wParent = window.parent.document;
					$('#txtWorkgno1').val(wParent.getElementById("txtNoa").value);
					$('#txtWorkgno2').val(wParent.getElementById("txtNoa").value);
					if(wParent.getElementById("txtEdate").value!='')
						$('#txtEnddate').val(wParent.getElementById("txtEdate").value);
					if(wParent.getElementById("txtSfedate").value!='' && wParent.getElementById("cmbStype").value=='3')
						$('#txtEnddate').val(wParent.getElementById("txtSfedate").value);
					
					var parent_recno=(window.parent.q_recno>=window.parent.brwCount?window.parent.q_recno%window.parent.brwCount:window.parent.q_recno);
					
					//103/12/26 預設先代入訂單預交日或製成品入庫日 最晚的日期
					$('#txtEnddate2').val(wParent.getElementById("txtWedate").value>wParent.getElementById("txtEdate").value?wParent.getElementById("txtWedate").value:wParent.getElementById("txtEdate").value);
					
					if(wParent.getElementById("vtunordb_"+parent_recno).innerHTML==''){
						$('#btnOrda').attr('disabled', 'disabled');
						$('#btnOrda2ordb').attr('disabled', 'disabled');
						$('#btnOrdb').attr('disabled', 'disabled');
						
						$('#btnOrda').css('font-weight', '' );
						$('#btnOrda').css('color', '');
						$('#btnOrdb').css('font-weight', '' );
						$('#btnOrdb').css('color', '');
						$('#btnOrda2ordb').css('font-weight', '' );
						$('#btnOrda2ordb').css('color', '');
						
					}else if(wParent.getElementById("vtunorda_"+parent_recno).innerHTML==''){
						$('#btnOrda').attr('disabled', 'disabled');
						$('#btnOrdb').attr('disabled', 'disabled');
						$('#btnOrda2ordb').removeAttr('disabled');
						
						$('#btnOrda').css('font-weight', '' );
						$('#btnOrda').css('color', '');
						$('#btnOrdb').css('font-weight', '' );
						$('#btnOrdb').css('color', '');
						$('#btnOrda2ordb').css('font-weight', 'bold');
						$('#btnOrda2ordb').css('color', 'blue');
					}else{
						$('#btnOrda').removeAttr('disabled');
						$('#btnOrdb').removeAttr('disabled');
						$('#btnOrda2ordb').removeAttr('disabled');
						
						$('#btnOrda').css('font-weight', 'bold');
						$('#btnOrda').css('color', 'blue');
						$('#btnOrdb').css('font-weight', 'bold');
						$('#btnOrdb').css('color', 'blue');
						$('#btnOrda2ordb').css('font-weight', 'bold');
						$('#btnOrda2ordb').css('color', 'blue');
					}
					if(wParent.getElementById("vtunorda_"+parent_recno).innerHTML=='' && wParent.getElementById("txtOrdano").value.substr(0,2)=='OA'){
						$('#btnOrdabox').removeAttr('disabled');
						$('#btnOrdabox').css('font-weight', 'bold');
						$('#btnOrdabox').css('color', 'blue');
					}else{
						$('#btnOrdabox').attr('disabled', 'disabled');
						$('#btnOrdabox').css('font-weight', '' );
						$('#btnOrdabox').css('color', '');
					}
				}
                
                $('#btnOk').hide();
                /*if(isorda){
					$('#btnOrdb').hide();
					$('#btnOrda').show();
					$('#btnOrda2ordb').hide();
				}else{
					$('#btnOrdb').show();
					$('#btnOrda').hide();
					$('#btnOrda2ordb').hide();
				}*/
				
				$('#txtWorkgno1').change(function() {
					if($('#chkWorkgall [type]=checkbox').prop('checked'))
						q_gt('view_workg', "where=^^isnull(ordbno,'')='' and isnull(ordano,'')=''^^", 0, 0, 0, "view_workg", r_accy);
					else
						q_gt('view_workg', "where=^^ noa between '"+$('#txtWorkgno1').val()+"' and '"+(emp($('#txtWorkgno2').val())?'CHAR(255)':$('#txtWorkgno2').val())+"' ^^ ", 0, 0, 0, "view_workg", r_accy);
						
					$('#chkOtherworkg [type]=checkbox').removeAttr('disabled');
					$('#txtEnddate1').removeAttr('disabled');
					$('#txtEnddate2').removeAttr('disabled');
					$('#chkXordc [type]=checkbox').removeAttr('disabled');
					$('#chkXsafe [type]=checkbox').removeAttr('disabled');
					$('#chkXstore [type]=checkbox').removeAttr('disabled');
					//$('#chkWorkgall [type]=checkbox').removeAttr('disabled');
					
	            });
	            $('#txtWorkgno2').change(function() {
					if($('#chkWorkgall [type]=checkbox').prop('checked'))
						q_gt('view_workg', "where=^^isnull(ordbno,'')='' and isnull(ordano,'')=''^^", 0, 0, 0, "view_workg", r_accy);
					else
						q_gt('view_workg', "where=^^ noa between '"+$('#txtWorkgno1').val()+"' and '"+(emp($('#txtWorkgno2').val())?'CHAR(255)':$('#txtWorkgno2').val())+"' ^^ ", 0, 0, 0, "view_workg", r_accy);
						
					$('#chkOtherworkg [type]=checkbox').removeAttr('disabled');
					$('#txtEnddate1').removeAttr('disabled');
					$('#txtEnddate2').removeAttr('disabled');
					$('#chkXordc [type]=checkbox').removeAttr('disabled');
					$('#chkXsafe [type]=checkbox').removeAttr('disabled');
					$('#chkXstore [type]=checkbox').removeAttr('disabled');
					//$('#chkWorkgall [type]=checkbox').removeAttr('disabled');
	            });
	            $('#chkWorkgall [type]=checkbox').click(function() {
					if($('#chkWorkgall [type]=checkbox').prop('checked'))
						q_gt('view_workg', "where=^^isnull(ordbno,'')='' and isnull(ordano,'')=''^^", 0, 0, 0, "view_workg", r_accy);
					else
						q_gt('view_workg', "where=^^ noa between '"+$('#txtWorkgno1').val()+"' and '"+(emp($('#txtWorkgno2').val())?'CHAR(255)':$('#txtWorkgno2').val())+"' ^^ ", 0, 0, 0, "view_workg", r_accy);
				});
                
                $('#btnOrdb').click(function(){
                	if($('#chkWorkgall [type]=checkbox').prop('checked'))
                		q_gt('workg', "where=^^isnull(ordbno,'')='' and isnull(ordano,'')=''^^", 0, 0, 0, "ordb", r_accy);
                	else
                		q_gt('workg', "where=^^isnull(ordbno,'')='' and isnull(ordano,'')='' and noa between '"+$('#txtWorkgno1').val()+"' and '"+(emp($('#txtWorkgno2').val())?'CHAR(255)':$('#txtWorkgno2').val())+"' ^^ ", 0, 0, 0, "ordb", r_accy);
	            });
	            
	           $('#btnOrda').click(function(){
                	if($('#chkWorkgall [type]=checkbox').prop('checked'))
                		q_gt('workg', "where=^^isnull(ordbno,'')='' and isnull(ordano,'')=''^^", 0, 0, 0, "orda", r_accy);
                	else
                		q_gt('workg', "where=^^isnull(ordbno,'')='' and isnull(ordano,'')='' and noa between '"+$('#txtWorkgno1').val()+"' and '"+(emp($('#txtWorkgno2').val())?'CHAR(255)':$('#txtWorkgno2').val())+"' ^^ ", 0, 0, 0, "orda", r_accy);
	            });
	            
	            $('#btnOrdabox').click(function(){
                	q_box("orda.aspx?;;;charindex(noa,(select ordano+',' from view_workg where noa between '"+$('#txtWorkgno1').val()+"' and '"+(emp($('#txtWorkgno2').val())?'CHAR(255)':$('#txtWorkgno2').val())+"' group by ordano for xml path('')))>0", 'orda', "95%", "95%", q_getMsg("btnOrdabox"));
	            });
	            
	            $('#btnOrda2ordb').click(function(){
                	q_gt('orda', "where=^^isnull(workgno,'')!='' and isnull(ordbno,'')='' and noa in (select zno from sign where enda='Y' and left(zno2,4)='orda') and noa in (select ordano from view_workg where noa between '"+$('#txtWorkgno1').val()+"' and '"+(emp($('#txtWorkgno2').val())?'CHAR(255)':$('#txtWorkgno2').val())+"') ^^ ", 0, 0, 0, "orda2ordb", r_accy);
	            });
	            
	            $('#btnCheck').click(function(){
	            	if($('#chkWorkgall [type]=checkbox').prop('checked'))
	            		q_gt('workg', "where=^^ isnull(ordano,'')='' and isnull(ordbno,'')='' ^^", 0, 0, 0, "check", r_accy);
	            	else
	            		q_gt('workg', "where=^^ isnull(ordano,'')='' and isnull(ordbno,'')='' and noa between '"+$('#txtWorkgno1').val()+"' and '"+(emp($('#txtWorkgno2').val())?'CHAR(255)':$('#txtWorkgno2').val())+"'^^", 0, 0, 0, "check", r_accy);
	            });
	            
	            $('.q_report .option div .c3').css("width","180px");
	            $('.q_report .option div .c6').css("width","110px");
	           
	            $('#Otherworkg .c6').css('width','0px');
	            $('#chkOtherworkg').css('width','290px');
	            $('#Otherworkg').css('width','300px');
	            
	            $('#Enddate').css('width','300px');
	            $('#txtEnddate1').css('width','80px');
	            $('#txtEnddate2').css('width','80px');
	            $('#Xordc .c6').css('width','0px');
	            $('#chkXordc').css('width','290px');
	            $('#Xordc').css('width','300px');
	            $('#Xsafe .c6').css('width','0px');
	            $('#chk Xsafe').css('width','290px');
	            $('#Xsafe').css('width','300px');
	            $('#Xstore .c6').css('width','0px');
	            $('#chk Xstore').css('width','290px');
	            $('#Xstore').css('width','300px');
	            
	            $('#Workgall .c6').css('width','0px');
	            $('#chkWorkgall').css('width','290px');
	            $('#Workgall').css('width','300px');
	            
	            if (window.parent.q_name == 'workg') {
					var wParent = window.parent.document;
					q_gt('view_workg', "where=^^ noa = '"+wParent.getElementById("txtNoa").value+"' ^^ ", 0, 0, 0, "get_workg_memo2", r_accy);
					if(wParent.getElementById("txtOrdbno").value.length==0&&wParent.getElementById("txtOrdano").value.length==0){
						//$('#btnOk').click();
					}else
						$('#btnCheck').click();
				}
            }

            function q_boxClose(s2) {
            }

            function q_gtPost(t_name) {
				switch (t_name) {
					case 'get_workg_memo2':
						var as = _q_appendData("view_workg", "", true);
						if (as[0] != undefined) {
							if(as[0].memo2!='' && as[0].memo2 != undefined){
								$('#txtWorkgno1').val(as[0].memo2.split('**')[0]);
								$('#txtWorkgno2').val(as[0].memo2.split('**')[1]);
								if(as[0].memo2.split('**')[2]=='1')
									$('#chkOtherworkg [type]=checkbox').prop('checked','true');
								$('#txtEnddate1').val(as[0].memo2.split('**')[3]);
								$('#txtEnddate2').val(as[0].memo2.split('**')[4]);
								if(as[0].memo2.split('**')[5]=='1')
									$('#chkXordc [type]=checkbox').prop('checked','true');
								if(as[0].memo2.split('**')[6]=='1')
									$('#chkXsafe [type]=checkbox').prop('checked','true');
								if(as[0].memo2.split('**')[7]=='1')
									$('#chkXstore [type]=checkbox').prop('checked','true');	
								if(as[0].memo2.split('**')[8]=='1')
									$('#chkWorkgall [type]=checkbox').prop('checked','true');
								
								$('#chkOtherworkg [type]=checkbox').attr('disabled', 'disabled');
								$('#txtEnddate1').attr('disabled', 'disabled');
								$('#txtEnddate2').attr('disabled', 'disabled');
								$('#chkXordc [type]=checkbox').attr('disabled', 'disabled');
								$('#chkXsafe [type]=checkbox').attr('disabled', 'disabled');
								$('#chkXstore [type]=checkbox').attr('disabled', 'disabled');
								$('#chkWorkgall [type]=checkbox').attr('disabled', 'disabled');	
							}
						}
						break;
					case 'view_workg':
						var as = _q_appendData("view_workg", "", true);
						if (as[0] != undefined) {
							var isordb=false;
							var isorda=false;
							var isordano=false;
							for (var i = 0; i < as.length; i++) {
								if(as[i].ordano!='')
									isorda=true;
								if(as[i].ordbno!='')
									isordb=true;
									
								if(as[i].ordano!='' && as[i].ordano.substr(0,2)=='OA' &&!isordano)
									isordano=true;
							}
							if(isordb){
								$('#btnOrda').attr('disabled', 'disabled');
								$('#btnOrda2ordb').attr('disabled', 'disabled');
								$('#btnOrdb').attr('disabled', 'disabled');
								
								$('#btnOrda').css('font-weight', '');
								$('#btnOrda').css('color', '');
								$('#btnOrdb').css('font-weight', '');
								$('#btnOrdb').css('color', '');
								$('#btnOrda2ordb').css('font-weight', '');
								$('#btnOrda2ordb').css('color', '');
							}else if (isorda){
								$('#btnOrda').attr('disabled', 'disabled');
								$('#btnOrdb').attr('disabled', 'disabled');
								$('#btnOrda2ordb').removeAttr('readonly');
								
								$('#btnOrda').css('font-weight', '');
								$('#btnOrda').css('color', '');
								$('#btnOrdb').css('font-weight', '');
								$('#btnOrdb').css('color', '');
								$('#btnOrda2ordb').css('font-weight', 'bold');
								$('#btnOrda2ordb').css('color', 'blue');
							}else{
								$('#btnOrda').removeAttr('readonly');
								$('#btnOrdb').removeAttr('readonly');
								$('#btnOrda2ordb').removeAttr('readonly');
								
								$('#btnOrda').css('font-weight', 'bold');
								$('#btnOrda').css('color', 'blue');
								$('#btnOrdb').css('font-weight', 'bold');
								$('#btnOrdb').css('color', 'blue');
								$('#btnOrda2ordb').css('font-weight', 'bold');
								$('#btnOrda2ordb').css('color', 'blue');
							}
							if(isorda && isordano){
								$('#btnOrdabox').removeAttr('disabled');
								$('#btnOrdabox').css('font-weight', 'bold');
								$('#btnOrdabox').css('color', 'blue');
							}else{
								$('#btnOrdabox').attr('disabled', 'disabled');
								$('#btnOrdabox').css('font-weight', '' );
								$('#btnOrdabox').css('color', '');
							}
						}else{
							$('#btnOrda').attr('disabled', 'disabled');
							$('#btnOrda2ordb').attr('disabled', 'disabled');
							$('#btnOrdb').attr('disabled', 'disabled');
							$('#btnOrdabox').attr('disabled', 'disabled');
							
							$('#btnOrda').css('font-weight', '');
							$('#btnOrda').css('color', '');
							$('#btnOrdb').css('font-weight', '');
							$('#btnOrdb').css('color', '');
							$('#btnOrda2ordb').css('font-weight', '');
							$('#btnOrda2ordb').css('color', '');
							$('#btnOrdabox').css('font-weight', '' );
							$('#btnOrdabox').css('color', '');
						}
					break;
					case 'check':
						var as = _q_appendData("workg", "", true);
						if (as[0] != undefined) {
							var bdate=!emp($('#txtOdate1').val())?$('#txtOdate1').val():'#non';
		                	var edate=!emp($('#txtOdate2').val())?$('#txtOdate2').val():'#non';
		                	var bworkgno=!emp($('#txtWorkgno1').val())?$('#txtWorkgno1').val():'#non';
		                	var eworkgno=!emp($('#txtWorkgno2').val())?$('#txtWorkgno2').val():'#non';
							var bpno=!emp($('#txtXproductno1a').val())?$('#txtXproductno1a').val():'#non';
		                	var epno=!emp($('#txtXproductno2a').val())?$('#txtXproductno2a').val():'#non';
		                	var otherworkgall=!emp($('#q_report').data('info').sqlCondition[7].getValue())?$('#q_report').data('info').sqlCondition[7].getValue():'#non';
		                	var benddate=!emp($('#txtEnddate1').val())?$('#txtEnddate1').val():'#non';
		                	var eenddate=!emp($('#txtEnddate2').val())?$('#txtEnddate2').val():'#non';
		                	var ordc=!emp($('#q_report').data('info').sqlCondition[10].getValue())?$('#q_report').data('info').sqlCondition[10].getValue():'#non';
		                	var safe=!emp($('#q_report').data('info').sqlCondition[11].getValue())?$('#q_report').data('info').sqlCondition[11].getValue():'#non';
		                	var store=!emp($('#q_report').data('info').sqlCondition[12].getValue())?$('#q_report').data('info').sqlCondition[12].getValue():'#non';
		                	var workgall=!emp($('#q_report').data('info').sqlCondition[13].getValue())?$('#q_report').data('info').sqlCondition[13].getValue():'#non';
		                	
							var t_where = r_accy+ ';' + bdate+ ';' + edate+ ';' + bworkgno+ ';' + eworkgno+ ';' + bpno+ ';' + epno
											+';'+otherworkgall+';'+benddate+';'+eenddate+ ';' + ordc+';' + safe+';'+ store+';' + workgall+';'+r_userno+';'+q_getPara('sys.key_ordb');
							var t_para = "r_comp=" + q_getPara('sys.comp') + ",r_accy=" + r_accy + ",r_cno=" + r_cno;
							q_gtx("z_workg2ordb1", t_where + ";;" + t_para + ";;z_workg2ordb;;" + q_getMsg('qTitle'));
							
						}else{
							var bdate=!emp($('#txtOdate1').val())?$('#txtOdate1').val():'#non';
		                	var edate=!emp($('#txtOdate2').val())?$('#txtOdate2').val():'#non';
		                	var bworkgno=!emp($('#txtWorkgno1').val())?$('#txtWorkgno1').val():'#non';
		                	var eworkgno=!emp($('#txtWorkgno2').val())?$('#txtWorkgno2').val():'#non';
							var bpno=!emp($('#txtXproductno1a').val())?$('#txtXproductno1a').val():'#non';
		                	var epno=!emp($('#txtXproductno2a').val())?$('#txtXproductno2a').val():'#non';
		                	var otherworkgall=!emp($('#q_report').data('info').sqlCondition[7].getValue())?$('#q_report').data('info').sqlCondition[7].getValue():'#non';
		                	var benddate=!emp($('#txtEnddate1').val())?$('#txtEnddate1').val():'#non';
		                	var eenddate=!emp($('#txtEnddate2').val())?$('#txtEnddate2').val():'#non';
		                	var ordc=!emp($('#q_report').data('info').sqlCondition[10].getValue())?$('#q_report').data('info').sqlCondition[10].getValue():'#non';
		                	var safe=!emp($('#q_report').data('info').sqlCondition[11].getValue())?$('#q_report').data('info').sqlCondition[11].getValue():'#non';
		                	var store=!emp($('#q_report').data('info').sqlCondition[12].getValue())?$('#q_report').data('info').sqlCondition[12].getValue():'#non';
		                	var workgall=!emp($('#q_report').data('info').sqlCondition[13].getValue())?$('#q_report').data('info').sqlCondition[13].getValue():'#non';
		                	
							var t_where = r_accy+ ';' + bdate+ ';' + edate+ ';' + bworkgno+ ';' + eworkgno+ ';' + bpno+ ';' + epno
											+';'+otherworkgall+';'+benddate+';'+eenddate+ ';' + ordc+';' + safe+';' + store+';' + workgall+';'+r_userno+';'+q_getPara('sys.key_ordb');
							var t_para = "r_comp=" + q_getPara('sys.comp') + ",r_accy=" + r_accy + ",r_cno=" + r_cno;
							q_gtx("z_workg2ordb3", t_where + ";;" + t_para + ";;z_workg2ordb;;" + q_getMsg('qTitle'));
						}
						break;
					case 'ordb':
						var as = _q_appendData("workg", "", true);
						if (as[0] != undefined) {
							if(confirm("確定要轉至請購?"))
							{
								var bdate=!emp($('#txtOdate1').val())?$('#txtOdate1').val():'#non';
			                	var edate=!emp($('#txtOdate2').val())?$('#txtOdate2').val():'#non';
			                	var bworkgno=!emp($('#txtWorkgno1').val())?$('#txtWorkgno1').val():'#non';
			                	var eworkgno=!emp($('#txtWorkgno2').val())?$('#txtWorkgno2').val():'#non';
								var bpno=!emp($('#txtXproductno1a').val())?$('#txtXproductno1a').val():'#non';
			                	var epno=!emp($('#txtXproductno2a').val())?$('#txtXproductno2a').val():'#non';
			                	var otherworkgall=!emp($('#q_report').data('info').sqlCondition[7].getValue())?$('#q_report').data('info').sqlCondition[7].getValue():'#non';
			                	var benddate=!emp($('#txtEnddate1').val())?$('#txtEnddate1').val():'#non';
			                	var eenddate=!emp($('#txtEnddate2').val())?$('#txtEnddate2').val():'#non';
			                	var ordc=!emp($('#q_report').data('info').sqlCondition[10].getValue())?$('#q_report').data('info').sqlCondition[10].getValue():'#non';
			                	var safe=!emp($('#q_report').data('info').sqlCondition[11].getValue())?$('#q_report').data('info').sqlCondition[11].getValue():'#non';
			                	var store=!emp($('#q_report').data('info').sqlCondition[12].getValue())?$('#q_report').data('info').sqlCondition[12].getValue():'#non';
			                	var workgall=!emp($('#q_report').data('info').sqlCondition[13].getValue())?$('#q_report').data('info').sqlCondition[13].getValue():'#non';
		                		
								var t_where = r_accy+ ';' + bdate+ ';' + edate+ ';' + bworkgno+ ';' + eworkgno+ ';' + bpno+ ';' + epno
											+';'+otherworkgall+';'+benddate+';'+eenddate+ ';' + ordc+';' + safe+';'+ store+';' + workgall+';'+r_userno+';'+q_getPara('sys.key_ordb');
								var t_para = "r_comp=" + q_getPara('sys.comp') + ",r_accy=" + r_accy + ",r_cno=" + r_cno;
				                //q_gtx("z_workg2ordb2", t_where + ";;" + t_para + ";;z_workg2ordb;;" + q_getMsg('qTitle'));
				                q_func('qtxt.query.sign3', 'orda.txt,sign3,' + t_where);
							}
						}else{
							alert('已產生請購。');
						}
						break;
					case 'orda':
						var as = _q_appendData("workg", "", true);
						if (as[0] != undefined) {
							if(confirm("確定要轉至簽核?"))
							{
								var bdate=!emp($('#txtOdate1').val())?$('#txtOdate1').val():'#non';
			                	var edate=!emp($('#txtOdate2').val())?$('#txtOdate2').val():'#non';
			                	var bworkgno=!emp($('#txtWorkgno1').val())?$('#txtWorkgno1').val():'#non';
			                	var eworkgno=!emp($('#txtWorkgno2').val())?$('#txtWorkgno2').val():'#non';
								var bpno=!emp($('#txtXproductno1a').val())?$('#txtXproductno1a').val():'#non';
			                	var epno=!emp($('#txtXproductno2a').val())?$('#txtXproductno2a').val():'#non';
			                	var otherworkgall=!emp($('#q_report').data('info').sqlCondition[7].getValue())?$('#q_report').data('info').sqlCondition[7].getValue():'#non';
			                	var benddate=!emp($('#txtEnddate1').val())?$('#txtEnddate1').val():'#non';
			                	var eenddate=!emp($('#txtEnddate2').val())?$('#txtEnddate2').val():'#non';
			                	var ordc=!emp($('#q_report').data('info').sqlCondition[10].getValue())?$('#q_report').data('info').sqlCondition[10].getValue():'#non';
			                	var safe=!emp($('#q_report').data('info').sqlCondition[11].getValue())?$('#q_report').data('info').sqlCondition[11].getValue():'#non';
			                	var store=!emp($('#q_report').data('info').sqlCondition[12].getValue())?$('#q_report').data('info').sqlCondition[12].getValue():'#non';
			                	var workgall=!emp($('#q_report').data('info').sqlCondition[13].getValue())?$('#q_report').data('info').sqlCondition[13].getValue():'#non';
		                		
								var t_where = r_accy+ ';' + bdate+ ';' + edate+ ';' + bworkgno+ ';' + eworkgno+ ';' + bpno+ ';' + epno
											+';'+otherworkgall+';'+benddate+';'+eenddate+ ';' + ordc+';' + safe+';' + store+';' + workgall+';'+r_userno+';'+q_getPara('sys.key_orda');
								var t_para = "r_comp=" + q_getPara('sys.comp') + ",r_accy=" + r_accy + ",r_cno=" + r_cno;
				                //q_gtx("z_workg2ordb4", t_where + ";;" + t_para + ";;z_workg2ordb;;" + q_getMsg('qTitle'));
				                q_func('qtxt.query.sign1', 'orda.txt,sign1,' + t_where);
							}
						}else{
							alert('已產生過簽核。');
						}
						break;
					case 'orda2ordb':
						var as = _q_appendData("orda", "", true);
						if (as[0] != undefined) {
							if(confirm("確定將物料需求簽核轉至請購?"))
							{
								var bdate=!emp($('#txtOdate1').val())?$('#txtOdate1').val():'#non';
			                	var edate=!emp($('#txtOdate2').val())?$('#txtOdate2').val():'#non';
			                	var bworkgno=!emp($('#txtWorkgno1').val())?$('#txtWorkgno1').val():'#non';
			                	var eworkgno=!emp($('#txtWorkgno2').val())?$('#txtWorkgno2').val():'#non';
								var bpno=!emp($('#txtXproductno1a').val())?$('#txtXproductno1a').val():'#non';
			                	var epno=!emp($('#txtXproductno2a').val())?$('#txtXproductno2a').val():'#non';
			                	var otherworkgall=!emp($('#q_report').data('info').sqlCondition[7].getValue())?$('#q_report').data('info').sqlCondition[7].getValue():'#non';
			                	var benddate=!emp($('#txtEnddate1').val())?$('#txtEnddate1').val():'#non';
			                	var eenddate=!emp($('#txtEnddate2').val())?$('#txtEnddate2').val():'#non';
			                	var ordc=!emp($('#q_report').data('info').sqlCondition[10].getValue())?$('#q_report').data('info').sqlCondition[10].getValue():'#non';
			                	var safe=!emp($('#q_report').data('info').sqlCondition[11].getValue())?$('#q_report').data('info').sqlCondition[11].getValue():'#non';
			                	var store=!emp($('#q_report').data('info').sqlCondition[12].getValue())?$('#q_report').data('info').sqlCondition[12].getValue():'#non';
			                	var workgall=!emp($('#q_report').data('info').sqlCondition[13].getValue())?$('#q_report').data('info').sqlCondition[13].getValue():'#non';
		                		
								var t_where =r_accy+ ';' + bdate+ ';' + edate+ ';' + bworkgno+ ';' + eworkgno+ ';' + bpno+ ';' + epno
											+';'+otherworkgall+';'+benddate+';'+eenddate+ ';' + ordc+';' + safe+';' + store+';' + workgall+';'+r_userno+';'+q_getPara('sys.key_ordb');
								var t_para = "r_comp=" + q_getPara('sys.comp') + ",r_accy=" + r_accy + ",r_cno=" + r_cno;
				                //q_gtx("z_workg2ordb5", t_where + ";;" + t_para + ";;z_workg2ordb;;" + q_getMsg('qTitle'));
				                q_func('qtxt.query.sign2', 'orda.txt,sign2,' + t_where);
							}
						}else{
							q_gt('workg', "where=^^isnull(ordbno,'')='' and  noa between '"+$('#txtWorkgno1').val()+"' and '"+(emp($('#txtWorkgno2').val())?'CHAR(255)':$('#txtWorkgno2').val())+"' ^^ ", 0, 0, 0, "orda_workg", r_accy);
						}
						break;
					case 'orda_workg':
						var as = _q_appendData("workg", "", true);
						if (as[0] != undefined) {
							q_gt('workg', "where=^^isnull(ordano,'')='' and  noa between '"+$('#txtWorkgno1').val()+"' and '"+(emp($('#txtWorkgno2').val())?'CHAR(255)':$('#txtWorkgno2').val())+"' ^^ ", 0, 0, 0, "orda_workg_ordano", r_accy);
						}else{
							alert('已產生請購。');
						}
						break;
					case 'orda_workg_ordano':
						var as = _q_appendData("workg", "", true);
						if (as[0] != undefined) {
							alert('未產生簽核。');
						}else{
							q_gt('orda', "where=^^ordbno!='' and workgno between '"+$('#txtWorkgno1').val()+"' and '"+(emp($('#txtWorkgno2').val())?'CHAR(255)':$('#txtWorkgno2').val())+"' ^^ ", 0, 0, 0, "orda_ordbno", r_accy);
						}
						break;
					case 'orda_ordbno':
						var as = _q_appendData("orda", "", true);
						if (as[0] != undefined) {
							alert('已產生請購。');
						}else{
							alert('簽核未核准。');
						}
						break;
				}
			}
			function q_funcPost(t_func, result) {
                switch(t_func) {
                	case 'qtxt.query.sign1':
                		var as = _q_appendData("tmp0", "", true, true);
						if (as[0] != undefined) {
							q_func('sign.q_signForm', 'orda,,'+  as[0].ordano);
							alert('簽核送出。');
						}
						break;
					case 'qtxt.query.sign2':
                		var as = _q_appendData("tmp0", "", true, true);
						if (as[0] != undefined) {
							for(var i=0;i<as[0].ordbnos.split(',').length;i++){
								q_func('sign.q_signForm', 'ordb,'+r_accy+','+  as[0].ordbnos.split(',')[i]);
							}
							alert('簽核已轉請購。');
						}
                		break;
                	case 'qtxt.query.sign3':
                		var as = _q_appendData("tmp0", "", true, true);
						if (as[0] != undefined) {
							for(var i=0;i<as[0].ordbnos.split(',').length;i++){
								q_func('sign.q_signForm', 'ordb,'+r_accy+','+  as[0].ordbnos.split(',')[i]);
							}
							alert('已轉請購。');
						}
                		break;
                }
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
				<div id="q_report"> </div>
			</div>
			<div class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>