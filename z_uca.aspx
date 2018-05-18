<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title> </title>
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
		
			aPop = new Array(
				['txtBstoreno','','store','noa,store','txtBstoreno,txtBstore','store_b.aspx'],
				['txtEstoreno','','store','noa,store','txtEstoreno,txtEstore','store_b.aspx'],
				['txtBproductno','','ucaucc','noa,product','txtBproductno,txtBproduct','ucaucc_b.aspx'],
				['txtEproductno','','ucaucc','noa,product','txtEproductno,txtEproduct','ucaucc_b.aspx']
			);
			
			$(document).ready(function() {
				_q_boxClose();
				q_getId();
				q_gt('uccga', '', 0, 0, 0, "");
			});
			var xgroupanoStr = '';
			function q_gfPost() {
				$('#q_report').q_report({
					fileName : 'z_uca',
					options : [{
						type : '0',
						name : 'accy',
						value : q_getId()[4]
					}, {
						type : '1',
						name : 'date' //[2][3]
					}, {
						type : '2',
						name : 'product', //[4][5]
						dbf : 'ucaucc',
						index : 'noa,product',
						src : 'ucaucc_b.aspx'
					}, {
						type : '2',
						name : 'storeno', //[6][7]
						dbf : 'store',
						index : 'noa,store',
						src : 'store_b.aspx'
					}, {
						type : '6',
						name : 'edate' //[8]
					}, {
						type : '1',
						name : 'ordeno' //[9][10]
					}, {
						type : '5',
						name : 'ucctype', //[11]
						value : [q_getPara('report.all')].concat(q_getPara('uccst.typea').split(','))
						
					}, {
						type : '5',
						name : 'outtypea', //[12]
						value : ('all@全部,out@委外,notout@非委外').split(',')
					}, {
						type : '5',
						name : 'xgroupano', //[13]
						value : xgroupanoStr.split(',')
					}, {
						type : '6',
						name : 'xstyle' //[14]
					}, {
						type : '8',
						name : 'allucc',//[15]
						value : '1@'.split(',')
					}, {
						type : '2', //[16][17]
						name : 'xtgg',
						dbf : 'tgg',
						index : 'noa,comp',
						src : 'tgg_b.aspx'
					}, {
						type : '0', //[18]
						name : 'xucctype',
						value : q_getPara('uccst.typea')
					}, {
                        type : '6', //[19]
                        name : 'xuca'
                    },{
						type : '0',//[20]
						name : 'rlen',
						value : r_len
					}, {
						type : '0', //[25] 
						name : 'xproject',
						value : q_getPara('sys.project').toUpperCase()
					}]
				});
				q_popAssign();
				q_getFormat();
				q_langShow();
				
				if(r_len==4){                	
                	$.datepicker.r_len=4;
					//$.datepicker.setDefaults($.datepicker.regional["ENG"]);
                }
				
				$('#lblXuca').css("color","#0000ff");
				
				$('#lblXuca').click(function(e) {
                	q_box("ucaucc_b2.aspx?;;;;", 'uca', "60%", "620px", q_getMsg("popUcc"));
                });
                if(q_getPara('sys.project').toUpperCase()=='RB')
					$('#Ucctype select').val('2');
				if(r_rank <8)
					$('#btnCostbcc').attr('disabled', 'disabled');
					
				$('#txtDate1').mask(r_picd);
				$('#txtDate1').datepicker();
				$('#txtDate2').mask(r_picd);
				$('#txtDate2').datepicker();
				$('#txtDate1').val(q_date().substr(0,r_lenm)+'/01');
				$('#txtDate2').val(q_cdn(q_cdn(q_date().substr(0,r_lenm)+'/01',45).substr(0,r_lenm)+'/01',-1));
				$('#Xgroupano select').removeClass('c4');
				$('#Xgroupano select').val('#non');
				$('#txtEdate').mask(r_picd);
				$('#txtEdate').val(q_date().substr(0,r_len)+'/12/31');
				$('#txtExportDate').val(q_date());
				$('#txtExportDate').mask(r_picd); //2015/10/20轉點單加日期
				$('#txtExportDate').datepicker();
				
				$('#q_report .option ').css('width','800px');
				$('.option .a1').css('width','790px');
				$('.option .a2').css('width','390px');
				$('#Xuca').css("width","605px");

			/*	$('.c6').css('width','90px');
				$('.c2').css('width','150px');
				$('.c3').css('width','150px');
				
				$('.c5').css('width','px');
				$('.cmb').css('width','150px');*/
				$('#Allucc').css('width','390px').css('height','30px');
				$('#Allucc .label').css('width','100px');
				$('#chkAllucc').css('width', '0px').css('margin-top', '5px');
				$('#txtXuca').css("width","505px");
				 q_cmbParse('cmbType','0@全部,1@原料,2@製成品')
                $('#btnCostbcc').click(function(e) {
                    $('#divExport').toggle();
                    $('#textDate').val(q_date());
                });
                
                $('#btnDivexport').click(function(e) {
                    $('#divExport').hide();
                });
                
                $('#btnExport').click(function(e) {
                	var t_datea=emp($('#txtExportDate').val())?q_date():$('#txtExportDate').val();
                  	var t_type=emp($('#cmbType').val())?'0':$('#cmbType').val();
                  	var t_bstore=emp($('#txtBstoreno').val())?'#non':$('#txtBstoreno').val();
                  	var t_estore=emp($('#txtEstoreno').val())?'#non':$('#txtEstoreno').val();
                  	var t_bpno=emp($('#txtBproductno').val())?'#non':$('#txtBproductno').val();
                  	var t_epno=emp($('#txtEproductno').val())?'#non':$('#txtEproductno').val();
                  	if(confirm('匯入過程需要等待幾分鐘確定要執行?')){
        				Lock(1);
        				q_func( 'qtxt.query.stkucce','stkucc.txt,stkucce,' + t_datea+ ';'+t_type+ ';'+ t_bstore+ ';'+ t_estore+ ';'+ t_bpno+ ';'+ t_epno);
        			}
                });
			}
			
			function q_boxClose(s2) {
				 var ret;
                switch (b_pop) {
                	case 'uca':
                        ret = getb_ret();
                        if(ret==null)
                        	return;
                        var xuca='';
                        if(ret[0]!=undefined){
                        	for (var i = 0; i < ret.length; i++) {
                        		xuca+=ret[i].noa+'.'
                        	}
                        }
                        xuca=xuca.substr(0,xuca.length-1);
                        $('#txtXuca').val(xuca);
                        break;	
					
                }   /// end Switch
				b_pop = '';
			}
			
			function q_gtPost(s2) {
				switch (s2) {
					case 'uccga':
						var as = _q_appendData("uccga", "", true);
						var t_item = "#non@全部";
						if (as[0] != undefined) {
							for ( i = 0; i < as.length; i++) {
								t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].noa + ' . ' + as[i].namea;
							}
						}
						xgroupanoStr = t_item;
						q_gf('', 'z_uca');
						break;
				}
			}
			
			function q_funcPost(t_func, result) {
                switch(t_func) {
                    case 'qtxt.query.stkucce':
                    	 alert('資料匯入完成。');
                    	 Unlock(1); 
                        break;
                    default:
                        break;
                }
            }
		</script>
		<style type="text/css">
		</style>
	</head>
	<body id="z_accc" ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
		<div id="q_menu"> </div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;width:2000px;">
			<input type="button" id="btnCostbcc" value="轉盤點單"/>
			<div id="container">
				<div id="q_report"> </div>
			</div>
			<div class="prt" style="margin-left: -40px;">			
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
		<div id="divExport" style="display:none;position:absolute;top:200px;left:400px;width:400px;height:150px;background:RGB(237,237,237);">
            <table style="border:3px solid gray; width:100%; height: 100%;">              
                <tr>
                    <td colspan="4" align="left" style="background-color: pink;">
                    	<label style="width:30%;" >日期</label>
                    	<input type="text" id="txtExportDate" style="width:83%;" />
                    </td>
                </tr>
                <tr>
                    <td align="center" colspan="4" style="padding: 2px;text-align: center;border-width: 0px;background-color: pink;">                   
                         <select id="cmbType" style="float:center;width:50%;"> </select>
                    </td>
                </tr>
                <tr>
					<td colspan="4" align="left" style="background-color: pink;">
                    	<label style="width:25%;" >倉庫</label>
                    	<input type="text" id="txtBstoreno" style="width:20%;"/>
                    	<input type="text" id="txtBstore" style="width:20%;" disabled="disabled"/>
                    	<label style="width:10%;" >~</label>
                    	<input type="text" id="txtEstoreno" style="width:20%;" />
                    	<input type="text" id="txtEstore" style="width:20%;" disabled="disabled"/>
                    </td>
					
				</tr>
				<tr>
					<td colspan="4" align="left" style="background-color: pink;">
                    	<label style="width:25%;" >產品</label>
                    	<input type="text" id="txtBproductno" style="width:20%;"/>
                    	<input type="text" id="txtBproduct" style="width:20%;" disabled="disabled"/>
                    	<label style="width:10%;" >~</label>
                    	<input type="text" id="txtEproductno" style="width:20%;" />
                    	<input type="text" id="txtEproduct" style="width:20%;" disabled="disabled"/>
                    </td>
				</tr>
				<tr>
                    <td colspan="4" align="center" style="background-color: pink;color: blue;">
                    	※盤點單匯入前，請先【成本結轉】至當月。
                    </td>
                </tr>
                <tr>
                    <td colspan="2" align="center" style="background-color: pink;">
                    <input type="button" id="btnExport" style="width:70%;" value="匯入" />
                    </td>
                    <td colspan="2" align="center" style=" background-color: pink;">
                    <input type="button" id="btnDivexport" style="width:70%;" value="關閉"/>
                    </td>
                </tr>
            </table>
        </div>
	</body>
</html>