printf "/*******************************************************************************\n";
printf "*-------------------------------------------------------------------------------\n";
printf "*\n";
printf "* Copyright (c), 2014 Yichip Corp.\n";
printf "*\n";
printf "*ALL RIGHTS RESERVED\n";
printf "*                                                                               \n";
printf "********************************************************************************\n";
printf "*                                                                               \n";
printf "* File Name: YC_bt_patch.h                                                      \n";
printf "*                                                                               \n";
printf "* Abstract:                                                                     \n";
printf "*This file use for save the patch code of YC1021.                               \n";
printf "*******************************************************************************/\n";
printf "                                                                                \n";
printf "#ifndef __YC_BT_PATCH_H_                                                        \n";
printf "#define __YC_BT_PATCH_H_                                                        \n";
printf "                                                                                \n";
open(BINFILE,"bt_patch.bin") or die $!;
binmode (BINFILE);
printf "const unsigned char yc_patch[] = \n{\n";
while( read(BINFILE, $binData, 1) )
{

	if(ord($binData) < 0x10){
		printf "0x0";
	}else{
		printf "0x";
	}
	printf "%X, ", ord($binData);
	$cnt += 1;
	if($cnt > 15){
		$cnt = 0;
		printf "\n";
	}
}
printf "\n};\n";
close (BINFILE);


printf "                                                                                \n";
printf "#endif\n";