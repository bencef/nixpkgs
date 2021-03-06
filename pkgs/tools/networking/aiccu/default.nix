{ stdenv, fetchurl, gnutls, iproute, makeWrapper }:

stdenv.mkDerivation rec {

  name = "aiccu-${version}";
  version = "20070115";

  src = fetchurl {
    url = "https://www.sixxs.net/archive/sixxs/aiccu/unix/aiccu_20070115.tar.gz";
    sha256 = "2260f426c13471169ccff8cb4a3908dc5f79fda18ddb6a55363e7824e6c4c760";
  };

  buildInputs = [ gnutls iproute makeWrapper ];

  configureFlags = "--prefix=$out";
  installPhase = ''
    install -D -m 755 unix-console/aiccu $out/bin/aiccu
    install -D -m 644 doc/aiccu.sgml $out/doc/aiccu.sgml
    install -D -m 644 doc/aiccu.1 $out/share/man/man1/aiccu.1
    wrapProgram "$out/bin/aiccu" \
      --prefix PATH : "${iproute}/bin"
  '';

  meta = with stdenv.lib; {
    description = "Automatic IPv6 Connectivity Configuration Utility";
    homepage = "https://www.sixxs.net/tools/aiccu/";
    longDescription = ''
      A TIC+ heartbeart client for the public dynamic-IPv4 IPv6 tunnel beta test from the SixXS tunnel service provider.
    '';
    maintainers = with maintainers; [ edwtjo ];
    license = "SixXS";
  };

}
