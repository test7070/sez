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
			var uccgaItem = '';
			aPop = new Array(
				['txtBstoreno','','store','noa,store','txtBstoreno,txtBstore','store_b.aspx'],
				['txtEstoreno','','store','noa,store','txtEstoreno,txtEstore','store_b.aspx'],
				['txtBproductno','','ucaucc','noa,product','txtBproductno,txtBproduct','ucaucc_b.aspx'],
				['txtEproductno','','ucaucc','noa,product','txtEproductno,txtEproduct','ucaucc_b.aspx']
			);
			$(document).ready(function() {
				_q_boxClose();
				q_getId();
				if (uccgaItem.length == 0) {
					q_gt('uccga', '', 0, 0, 0, "");
				}
			});
			function q_gfPost() {
				$('#q_report').q_report({
					fileName : 'z_uccage',
					options : [{
						type : '0', //[1]
						name : 'accy',
						value : q_getId()[4]
					},{
                        type : '0',//[2]
                        name : 'r_len',
                        value : r_len
                    }, {
                        type : '0', //[3]
                        name : 'mountprecision',
                        value : q_getPara('vcc.mountPrecision')
                    }, {
                        type : '0', //[4]
                        name : 'weightprecision',
                        value : q_getPara('vcc.weightPrecision')
                    }, {
                        type : '0', //[5]
                        name : 'priceprecision',
                        value : q_getPara('vcc.pricePrecision')
                    }, {
						type : '0', //[6] 
						name : 'xproject',
						value : q_getPara('sys.project').toUpperCase()
					},{
                        type : '0',//[7]
                        name : 'isspec',
                        value : q_getPara('sys.isspec')
                    }, {
						type : '0', //[8]
						name : 'xgroupas',
						value : uccgaItem
					}, {
						type : '0', //[9]
						name : 'xucctype',
						value : q_getPara('ucc.typea')
					}, {//1-1
						type : '2',//[10][11]
						name : 'xproduct', 
						dbf : 'ucaucc',
						index : 'noa,product',
						src : 'ucaucc_b.aspx'
					}, {//1-2
						type : '2',//[12][13]
						name : 'xstoreno', 
						dbf : 'store',
						index : 'noa,store',
						src : 'store_b.aspx'
					}, {//1-3
						type : '5',//[14]
						name : 'xucctype', 
						value : [q_getPara('report.all')].concat(q_getPara('ucc.typea').split(','))
					}, {//1-4
						type : '5', //[15]
						name : 'xgroupano',
						value : uccgaItem.split(',')
					}, {//2-1
						type : '5', //[16]
						name : 'xgetdate',
						value : '3@出入庫日,1@出庫日,2@入庫日'.split(',')
					}, {//2-2
						type : '6',//[17]
						name : 'xenddate'
					}, {//2-3
						type : '8',//[18]
						name : 'showzero',
						value : '1@顯示零庫存產品'.split(',')
					}, {//2-4
						type : '8',//[19]
						name : 'showcost',
						value : '1@顯示成本金額'.split(',')
					}, {//3-1
						type : '6',//[20]
						name : 'xdatea'
					}, {//3-2
						type : '1',//[21][22]
						name : 'xdateb'
					}, {//3-3
						type : '1',//[23][24]
						name : 'xdatec'
					}, {//3-4
						type : '1',//[25][26]
						name : 'xdated'
					}, {//4-1
						type : '1',//[27][28]
						name : 'xdatee'
					}, {//4-2
						type : '6',//[29]
						name : 'xdatef'
					}]
				});
				q_popAssign();
				q_getFormat();
				q_langShow();
				
				if(r_len==4){$.datepicker.r_len=4;}
                
				$('#txtXenddate').mask(r_picd);
				$('#txtXenddate').datepicker();
				$('#txtXenddate').val(q_date());
								
				$('#Showzero').css('width','300px').css('height','30px');
				$('#Showzero .label').css('width','0px');
				$('#Showcost').css('width','300px').css('height','30px');
				$('#Showcost .label').css('width','0px');
				
				var tmp = document.getElementById("txtXdatea");
                var tdiv = document.createElement("div");
                tdiv.className = "label c6";
                tdiv.id="lblDiv1";
                tmp.parentNode.appendChild(tdiv,tmp);
                var tmp = document.getElementById("lblDiv1");
                var tspan = document.createElement("span");
                tspan.id="lblD1";
                tspan.innerText="天以內";
                tmp.appendChild(tspan,tmp);
                
                var tmp = document.getElementById("txtXdateb2");
                var tdiv = document.createElement("div");
                tdiv.className = "label c6";
                tdiv.id="lblDiv2";
                tdiv.style.cssText="width: 30px;";
                tmp.parentNode.appendChild(tdiv,tmp);
                var tmp = document.getElementById("lblDiv2");
                var tspan = document.createElement("span");
                tspan.id="lblD2";
                tspan.innerText="天";
                tmp.appendChild(tspan,tmp);
                
                var tmp = document.getElementById("txtXdatec2");
                var tdiv = document.createElement("div");
                tdiv.className = "label c6";
                tdiv.id="lblDiv3";
                tdiv.style.cssText="width: 30px;";
                tmp.parentNode.appendChild(tdiv,tmp);
                var tmp = document.getElementById("lblDiv3");
                var tspan = document.createElement("span");
                tspan.id="lblD3";
                tspan.innerText="天";
                tmp.appendChild(tspan,tmp);
                
                var tmp = document.getElementById("txtXdated2");
                var tdiv = document.createElement("div");
                tdiv.className = "label c6";
                tdiv.id="lblDiv4";
                tdiv.style.cssText="width: 30px;";
                tmp.parentNode.appendChild(tdiv,tmp);
                var tmp = document.getElementById("lblDiv4");
                var tspan = document.createElement("span");
                tspan.id="lblD4";
                tspan.innerText="天";
                tmp.appendChild(tspan,tmp);
                
                var tmp = document.getElementById("txtXdatee2");
                var tdiv = document.createElement("div");
                tdiv.className = "label c6";
                tdiv.id="lblDiv5";
                tdiv.style.cssText="width: 30px;";
                tmp.parentNode.appendChild(tdiv,tmp);
                var tmp = document.getElementById("lblDiv5");
                var tspan = document.createElement("span");
                tspan.id="lblD5";
                tspan.innerText="天";
                tmp.appendChild(tspan,tmp);
                
                var tmp = document.getElementById("txtXdatef");
                var tdiv = document.createElement("div");
                tdiv.className = "label c6";
                tdiv.id="lblDiv6";
                tmp.parentNode.appendChild(tdiv,tmp);
                var tmp = document.getElementById("lblDiv6");
                var tspan = document.createElement("span");
                tspan.id="lblD6";
                tspan.innerText="天以上";
                tmp.appendChild(tspan,tmp);
                
                $('#txtXdatea').css('width','110px');
                $('#txtXdatef').css('width','110px');
                $('#txtXdatea').css('text-align','right').val(60);
                $('#txtXdateb1').css('text-align','right').val(61);
                $('#txtXdateb2').css('text-align','right').val(120);
                $('#txtXdatec1').css('text-align','right').val(121);
                $('#txtXdatec2').css('text-align','right').val(180);
                $('#txtXdated1').css('text-align','right').val(181);
                $('#txtXdated2').css('text-align','right').val(360);
                $('#txtXdatee1').css('text-align','right').val(361);
                $('#txtXdatee2').css('text-align','right').val(720);
                $('#txtXdatef').css('text-align','right').val(721);
                $('#Xdateb').css('width','370px');
                $('#Xdatec').css('width','370px');
                $('#Xdated').css('width','370px');
                $('#Xdatee').css('width','370px');
				$('#txtXdatea').change(function() {
					$(this).val(dec($(this).val()));
					if(isNaN($(this).val())){$(this).val(9999);}
				});
				$('#txtXdateb1').change(function() {
					$(this).val(dec($(this).val()));
					if(isNaN($(this).val())){$(this).val(9999);}
				});
				$('#txtXdateb2').change(function() {
					$(this).val(dec($(this).val()));
					if(isNaN($(this).val())){$(this).val(9999);}
				});
				$('#txtXdatec1').change(function() {
					$(this).val(dec($(this).val()));
					if(isNaN($(this).val())){$(this).val(9999);}
				});
				$('#txtXdatec2').change(function() {
					$(this).val(dec($(this).val()));
					if(isNaN($(this).val())){$(this).val(9999);}
				});
				$('#txtXdated1').change(function() {
					$(this).val(dec($(this).val()));
					if(isNaN($(this).val())){$(this).val(9999);}
				});
				$('#txtXdated2').change(function() {
					$(this).val(dec($(this).val()));
					if(isNaN($(this).val())){$(this).val(9999);}
				});
				$('#txtXdatee1').change(function() {
					$(this).val(dec($(this).val()));
					if(isNaN($(this).val())){$(this).val(9999);}
				});
				$('#txtXdatee2').change(function() {
					$(this).val(dec($(this).val()));
					if(isNaN($(this).val())){$(this).val(9999);}
				});
				$('#txtXdatef').change(function() {
					$(this).val(dec($(this).val()));
					if(isNaN($(this).val())){$(this).val(9999);}
				});
			}

			function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                					
                }   /// end Switch
				b_pop = '';
            }

			function q_gtPost(t_name) {
				switch (t_name) {
					case 'uccga':
						var as = _q_appendData("uccga", "", true);
						uccgaItem = "#non@全部";
						for ( i = 0; i < as.length; i++) {
							uccgaItem = uccgaItem + (uccgaItem.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].noa + ' . ' + as[i].namea;
						}
						q_gf('', 'z_uccage');
						break;
				}
			}
			
			
			function q_funcPost(t_func, result) {
                switch(t_func) {
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
			<div id="container">
				<div id="q_report"> </div>
			</div>
			<div class="prt" style="margin-left: -40px;">			
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>