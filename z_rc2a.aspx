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
            t_cno = '';
            $(document).ready(function() {
                q_getId();
                q_gt('acomp', 'where=^^ exists(select top 1 noa from vcca where acomp.noa=vcca.cno) ^^', 0, 0, 0);
            });
            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'acomp':
                        t_cno = '';
                        var as = _q_appendData("acomp", "", true);
                        for ( i = 0; i < as.length; i++) {
                            t_cno += (t_cno.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].nick;
                        }
                        q_gf('', 'z_rc2a');
                        break;
                }
            }

            function q_gfPost() {
				$('#q_report').q_report({
                    fileName : 'z_rc2a',
                    options : [{
                        type : '1',
                        name : 'date'
                    }, {
                        type : '1',
                        name : 'mon'
                    }, {
                        type : '2',
                        name : 'tgg',
                        dbf : 'tgg',
                        index : 'noa,comp',
                        src : 'tgg_b.aspx'
                    }, {
                        type : '2',
                        name : 'product',
                        dbf : 'ucca',
                        index : 'noa,product',
                        src : 'ucca_b.aspx'
                    }, {//  [9]
                        type : '8',
                        name : 'xcno',
                        value : t_cno.split(',')
                    }]
                });

				q_popAssign();
				q_getFormat();
				q_langShow();

				if (r_len == 4) {
					$.datepicker.r_len = 4;
					//$.datepicker.setDefaults($.datepicker.regional["ENG"]);
				}

				$('#txtDate1').mask(r_picd);
				$('#txtDate1').datepicker();
				$('#txtDate2').mask(r_picd);
				$('#txtDate2').datepicker();
				$('#txtMon1').mask(r_picm);
				$('#txtMon2').mask(r_picm);

				$('#txtDate1').val(q_date().substr(0, r_lenm) + '/01');
				$('#txtDate2').val(q_cdn(q_cdn(q_date().substr(0, r_lenm) + '/01', 45).substr(0, r_lenm) + '/01', -1));
				
				if(q_getPara('sys.project').toUpperCase()!='BD'){
					var t_index=-1;
					for(var i=0;i<$('#q_report').data().info.reportData.length;i++){
						if($('#q_report').data('info').reportData[i].report=='z_rc2a11'){
							t_index=i;
							break;	
						}
					}
					if(t_index>-1){
						$('#q_report div div').eq(i).hide();
					}
				}
				
            }

            function q_boxClose(s2) {
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