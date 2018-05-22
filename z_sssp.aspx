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
		aPop = new Array(['txtXcarno', '', 'cicar', 'a.noa,cust', 'txtXcarno', 'cicar_b.aspx'],
						 ['txtXcardealno', '', 'cicardeal', 'noa,comp', 'txtXcardealno', 'cardeal_b.aspx'],
						 ['txtXinsurerno', '', 'ciinsucomp', 'noa,insurer', 'txtXinsurerno', 'ciinsucomp_b.aspx'],
						  ['txtXsales', '', 'cisale', 'noa,namea', 'txtXsales', 'cisale_b.aspx']
		);
            if (location.href.indexOf('?') < 0) {
                location.href = location.href + "?;;;;"+((new Date()).getUTCFullYear()-1911);
            }
            $(document).ready(function() {
                q_getId();
                q_gf('', 'z_sssp');   
            });
            function q_gfPost() {
                $('#q_report').q_report({
                    fileName : 'z_sssp',
                    options : [{
						type : '0',
						name : 'sss',
						value : r_userno
                    },{
                        type : '6',
                        name : 'xmon'
                    },{
                        type : '5',
                        name : 'xkind',
                        value : (('').concat(new Array("本月","上期","下期"))).split(',')
                    },{
                        type : '6',
                        name : 'xyear'
                    }]
                });
                q_langShow();
	            q_popAssign();
	            
                $('#txtXmon').mask(r_picm);
                $('#txtXyear').mask(r_pic);
                
                var t_date=q_cdn(q_date().substring(0, r_lenm)+'/01',-1).substring(0, r_lenm);
                $('#txtXmon').val(t_date);
                $('#txtXyear').val(t_date.substr(0,r_len));
                
                //1030909 副總 不讓員工列印
                if(q_getPara('sys.comp').indexOf('大昌')>-1){
	                $('.prt input').not('#btnAuthority').not("#btnOk").not("#btnTop").not("#btnPrev").not("#btnNext").not("#btnBott").not("#txtPageno").not("#txtEnd").hide();
	                $('.prt select').hide();
	                $('.prt a').hide();
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