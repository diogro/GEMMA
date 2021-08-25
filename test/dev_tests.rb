
require 'minitest/autorun'
require 'lib/test-helpers'

class TestQuick < MiniTest::Test

  include TestHelpers

  def setup
  end

  def test_linear_model
    assert gemma("-g ./example/mouse_hs1940.geno.txt.gz \
           -p ./example/mouse_hs1940.pheno.txt \
           -n 1 \
           -a ./example/mouse_hs1940.anno.txt \
           -lm \
           -o mouse_hs1940_CD8_lm")

    expect('output/mouse_hs1940_CD8_lm.assoc.txt',[[2,1,"rs3707673"],
                                                   [2,10,"5.252187e-05"],
                                                   [3,9,"3.909916e-02"]])
  end

  def test_BXD
    assert gemma("-g ./example/BXD_geno.txt.gz \
           -p ./example/BXD_pheno.txt \
           -c ./example/BXD_covariates2.txt \
           -a ./example/BXD_snps.txt \
           -gk \
           -o BXD")

    assert gemma("-g ./example/BXD_geno.txt.gz \
           -p ./example/BXD_pheno.txt \
           -c ./example/BXD_covariates2.txt \
           -a ./example/BXD_snps.txt \
           -k ./output/BXD.cXX.txt \
           -lmm 2 -no-check -maf 0.1 \
           -o BXDLMM")

    expect("output/BXDLMM.assoc.txt",[[2,9,"1.234747e-01"],
                                      [:max,9,"9.997119e-01"]])
  end

  def test_mouse_hs1940_loco
    assert gemma("-g ./example/mouse_hs1940.geno.txt.gz \
           -p ./example/mouse_hs1940.pheno.txt \
           -a ./example/mouse_hs1940.anno.txt \
           -snps ./example/mouse_hs1940_snps.txt \
           -nind 400 -loco 1 -gk \
           -o mouse_hs1940_loco")

    assert gemma("-g ./example/mouse_hs1940.geno.txt.gz \
           -p ./example/mouse_hs1940.pheno.txt \
	   -n 1 \
	   -loco 1 \
           -a ./example/mouse_hs1940.anno.txt \
           -k ./output/mouse_hs1940_loco.cXX.txt \
	   -snps ./example/mouse_hs1940_snps.txt \
           -lmm \
	   -nind 400 -no-check \
           -o mouse_hs1940_loco")
    expect("output/mouse_hs1940_loco.assoc.txt",[[2,9,"-3.073643e+02"],
                                                 [:max,11,"9.716047e-01"]])
  end
end
