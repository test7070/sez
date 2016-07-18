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
						value : '1@出庫日,2@入庫日,3@出入庫日'.split(',')
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