use strict;
use warnings;

sub read_definfo{
	my $filename = shift();
	my $const_chip = "CHIP VERSION£º";
	my $const_config = "CONFIG: ";
	my $version = "";
	my @res;
	open(FILE,$filename) || die("can not open file:$filename £¡\n");
	while(my $line = <FILE>){
		next if ($line eq "\n"||$line =~ "REVD");
		last if ($line =~ "INCLUDE");
		last if ($line =~ "SIMPLE_PAIRING");
		
		if ($line =~ "FPGA" && $line !~ "//"){
			$version = $version."FPGA";
		}elsif($line =~ "ROMCODE" && $line !~ "//"){
			$version = $version."ROMCODE";
			print $const_chip.$version."\n\n";
		}elsif($line !~ "//"){				# valid
			if ($line =~"liandi"){
				print "baud rate  : boot rate\n";
				}
			elsif ($line =~ "CREDIT"){
				print "credit     : from mcu\n";
				}
			elsif ($line =~ "SSP_EXT"){
				print "ssp confirm: suport\n";
				}
			elsif ($line =~ "NVRAM"){
				print "nvram      : by mcu\n";
			}elsif ($line=~"RELEASE"){
				print "version    : release\n";
			}
		}elsif ($line =~ "//"){				#noted
			if ($line =~"liandi"){
				print "baud rate  : 115200 or other \n";
				}
			elsif ($line =~ "CREDIT"){
				print "credit     : auto\n";
				}
			elsif ($line =~ "SSP_EXT"){
				print "ssp confirm: justwork only\n";
				}
			elsif ($line =~ "NVRAM"){
				print "nvram      : in eep\n";
			}elsif ($line =~ "RELEASE"){
				print "version    : debug\n";
			}
		}
	}
}

&read_definfo("bt.prog");