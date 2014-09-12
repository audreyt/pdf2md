use strict;
use Storable qw(nstore);
local @ARGV = 'kaiu.svg';
local $/ = "/>";
my (%PathToCode, %CodeToPath);
while (<>) {
   s/\s+/ /g;
   next unless /<glyph[^>]*unicode="([^"]+)"[^>]*d="([^"]+)/;
   $PathToCode{$2} = $1;
   $CodeToPath{$1} = $2;
}
local @ARGV = 'f1.svg';
use HTML::Entities qw[ decode_entities ];
my %Map;
while (<>) {
   s/\s+/ /g;
   next unless /<glyph[^>]*unicode="([^"]+)"[^>]*d="([^"]+)/;
   $Map{decode_entities($1)} = decode_entities($PathToCode{$2});
}

local $/;
local @ARGV = 'foo.csv';
my $html = <>;
use Encode;
Encode::_utf8_on($html);
$Map{"\cM"} = '';
$html = join '', map { $Map{$_} // $_ } split(//, $html);
$html =~ s<"T":"\K([^"]*)><
    my $x = $1;
    $x =~ s/%([0-9A-Fa-f]{2})/chr(hex($1))/eg;
    $x = Encode::decode_utf8($x);
    join '', map { $Map{$_} // $_ } split(//, $x);
>eg if 0;
print $html;
