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
            aPop = new Array();
            if (location.href.indexOf('?') < 0) {
                location.href = location.href + "?;;;;" + ((new Date()).getUTCFullYear() - 1911);
            }

            $(document).ready(function() {
                q_getId();
                //q_gf('', 'z_workgv');
                q_gt('uccga', '', 0, 0, 0, "");
                q_gt('uccgb', '', 0, 0, 0, "");
                q_gt('uccgc', '', 0, 0, 0, "");
                
            });
            
            function q_gfPost() {
                $('#q_report').q_report({
                    fileName : 'z_workgv',
                    options : [{
                        type : '1',//[1,2]
                        name : 'xmon'
                    }, {
                        type : '2',//[3,4]
                        name : 'xproduct',
                        dbf : 'ucaucc',
                        index : 'noa,product',
                        src : 'ucaucc_b.aspx'
                    }, {
                        type : '2',//[5,6]
                        name : 'xtgg',
                        dbf : 'tgg',
                        index : 'noa,comp',
                        src : 'tgg_b.aspx'
                    }, {
						type : '6', //[7]
						name : 'xstyle'
					},{
                        type : '8', //[8]
                        name : 'showworkg',
                        value : "1@只顯示需排產".split(',')
                    },{
                        type : '8', //[9]
                        name : 'showordb',
                        value : "1@只顯示需備料".split(',')
                    },{
                        type : '8', //[10]
                        name : 'showforecast',
                        value : "1@只顯示有預測資料".split(',')
                    }, {
						type : '5', //[11]/
						name : 'xgroupano',
						value : uccgaItem.split(',')
					}, {
						type : '5', //[12]/
						name : 'xgroupbno',
						value : uccgbItem.split(',')
					}, {
						type : '5', //[13]/
						name : 'xgroupcno',
						value : uccgcItem.split(',')
					}, {/* [14]*/
                        type : '0',
                        name : 'rlen',
                        value : r_len
                    }, {/* [15]*/
                        type : '0',
                        name : 'xnowdate',
                        value : q_date()
                    }]
                });
                
                q_popAssign();
				q_getFormat();
				q_langShow();
                
                $('#txtXmon1').mask(r_picm);
                $('#txtXmon1').val(q_date().substr(0, r_lenm));
 				$('.q_report .option:first').css('width','700px')
				$('#Xproduct').css('width','690px');
				$('#Xproduct .c2').css('width','130px');
				$('#Xproduct .c3').css('width','130px');
				$('#Xmon').css('width','340px');
				$('#Showworkg').css('width','340px').css('height','');
				$('#Showordb').css('width','340px').css('height','');
				$('#Showforecast').css('width','340px').css('height','');
				$('#chkShowworkg').css('width','260px').css('margin-top','5px');
				$('#chkShowordb').css('width','260px').css('margin-top','5px');
				$('#chkShowforecast').css('width','260px').css('margin-top','5px');
				$('#chkShowforecast [type]=checkbox').prop('checked','ture');
				$('.q_report .option div.a2').css('width','340px');
				$('.q_report .option div .c5').css('width','240px');
				$('#Xstyle').css('width','345px');
				
				
				$('#txtXmon2').val(q_cdn(q_date().substr(0, r_lenm)+'/01',170).substr(0, r_lenm));
                
                $('#txtXmon2').mask(r_picm);
            }

            function q_boxClose(s2) {
            }
			var firstRun = false;
			var uccgaItem = '';
			var uccgbItem = '';
			var uccgcItem = '';
			
            function q_gtPost(t_name) {
				switch (t_name) {
					case 'uccga':
						var as = _q_appendData("uccga", "", true);
						uccgaItem = "#non@全部";
						for ( i = 0; i < as.length; i++) {
							uccgaItem = uccgaItem + (uccgaItem.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].noa + ' . ' + as[i].namea;
						}
						break;
					case 'uccgb':
						var as = _q_appendData("uccgb", "", true);
						uccgbItem = "#non@全部";
						for ( i = 0; i < as.length; i++) {
							uccgbItem = uccgbItem + (uccgbItem.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].noa + ' . ' + as[i].namea;
						}
						break;
					case 'uccgc':
						var as = _q_appendData("uccgc", "", true);
						uccgcItem = "#non@全部";
						for ( i = 0; i < as.length; i++) {
							uccgcItem = uccgcItem + (uccgcItem.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].noa + ' . ' + as[i].namea;
						}
						break;
				}
				if (uccgaItem.length > 0 && uccgbItem.length > 0 && uccgcItem.length > 0 && !firstRun) {
					q_gf('', 'z_workgv');
					firstRun=true;
				}
			}
		</script>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
		<div id="q_menu"></div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;width:2000px;">
			<div id="container">
				<div id="q_report"></div>
			</div>
			<div class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>

