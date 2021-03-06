require 'spec_helper'

describe SyllableSeparator do
  matcher :separate_as do |expected|
    result = nil
    match do |actual|
      result = SyllableSeparator.new(actual).separate
      result == expected
    end
    failure_message do |actual|
      %( expected "#{actual}" to separate as "#{expected}", but was "#{result}")
    end
  end

  it 'separates simple words' do
    expect('bola').to separate_as %w(bo la)
    expect('batata').to separate_as %w(ba ta ta)
  end

  it 'keeps some "dígrafos" together' do
    expect('chocalho').to separate_as %w(cho ca lho)
    expect('batuque').to separate_as %w(ba tu que)
    expect('guelha').to separate_as %w(gue lha)
  end

  it 'separates other "dígrafos"' do
    expect('bossa').to separate_as %w(bos sa)
    expect('bosta').to separate_as %w(bos ta)
    expect('cassado').to separate_as %w(cas sa do)
    expect('carrasco').to separate_as %w(car ras co)
  end

  it 'handles double consonants border cases' do
    expect('destravar').to separate_as %w(des tra var)
    expect('desencontro').to separate_as %w(de sen con tro)
    expect('exaltar').to separate_as %w(e xal tar)
    expect('excomungar').to separate_as %w(ex co mun gar)
  end

  it 'keeps "oclusivas" and "fricativas" together with "r" or "l"' do
    expect('brasa').to separate_as %w(bra sa)
    expect('agrupado').to separate_as %w(a gru pa do)
    expect('fragrância').to separate_as %w(fra grân ci a)
    expect('protocriogênico').to separate_as %w(pro to cri o gê ni co)
  end

  it 'keeps long codas' do
    expect('transpiração').to separate_as %w(trans pi ra ção)
    expect('transatlântico').to separate_as %w(tran sa tlân ti co)
    expect('mirins').to separate_as %w(mi rins)
    expect('transerrano').to separate_as %w(tran ser ra no)
    expect('solstício').to separate_as %w(sols tí ci o)
    expect('perspectiva').to separate_as %w(pers pec ti va)
    expect('substância').to separate_as %w(subs tân ci a)
    # Yes! It's a real word o_O
    expect('falansterialismo').to separate_as %w(fa lans te ri a lis mo)
  end

  it 'separates single vowels at beginning' do
    expect('abacaxi').to separate_as %w(a ba ca xi)
    expect('exceto').to separate_as %w(ex ce to)
    expect('arrocho').to separate_as %w(ar ro cho)
  end

  it 'keeps "ditongos" together' do
    expect('maizena').to separate_as %w(mai ze na)
    expect('mausoléu').to separate_as %w(mau so léu)
    expect('ação').to separate_as %w(a ção)
    expect('põe').to separate_as %w(põe)
    expect('exceção').to separate_as %w(ex ce ção)
  end

  it 'handle "tritongos"' do
    expect('ideia').to separate_as %w(i dei a)
    expect('tireoide').to separate_as %w(ti re oi de)
    expect('praia').to separate_as %w(prai a)
    expect('feio').to separate_as %w(fei o)
    expect('vaia').to separate_as %w(vai a)
  end

  it 'separates "hiatos"' do
    expect('moeda').to separate_as %w(mo e da)
    expect('leal').to separate_as %w(le al)
    expect('aéreo').to separate_as %w(a é re o)
    expect('pior').to separate_as %w(pi or)
    expect('raíz').to separate_as %w(ra íz)
    expect('ruído').to separate_as %w(ru í do)
  end

  it 'keeps the first consonant of the word together' do
    expect('pneu').to separate_as %w(pneu)
    expect('apneia').to separate_as %w(ap nei a)
    expect('pneumático').to separate_as %w(pneu má ti co)
    expect('piropneumático').to separate_as %w(pi rop neu má ti co)
    expect('mnemônica').to separate_as %w(mne mô ni ca)
    expect('pseudônimo').to separate_as %w(pseu dô ni mo)
    expect('psicólogo').to separate_as %w(psi có lo go)
    expect('gnomo').to separate_as %w(gno mo)
  end

  it 'keeps "sineréses" together' do
    expect('saudade').to separate_as %w(sau da de)
    expect('vaidade').to separate_as %w(vai da de)
    expect('suave').to separate_as %w(su a ve)
  end

  it 'separates "dieréses"' do
    expect('conluiador').to separate_as %w(con lui a dor)
    expect('conluio').to separate_as %w(con lui o)
    expect('aleluia').to separate_as %w(a le lui a)
    expect('toluico').to separate_as %w(to lui co)

    expect('alauita').to separate_as %w(a lau i ta)

    expect('rainha').to separate_as %w(ra i nha)
    expect('tainheira').to separate_as %w(ta i nhei ra)

    expect('construir').to separate_as %w(cons tru ir)
    expect('destruir').to separate_as %w(des tru ir)
    expect('destruição').to separate_as %w(des tru i ção)
  end

  it 'separates random words' do
    expect('acidentariamente').to separate_as %w(a ci den ta ri a men te)
    expect('cooperar').to separate_as %w(co o pe rar)
    expect('abstraído').to separate_as %w(abs tra í do)
    expect('abstenção').to separate_as %w(abs ten ção)
    expect('colapso').to separate_as %w(co lap so)
    expect('piauí').to separate_as %w(pi au í)
    expect('aguei').to separate_as %w(a guei)
    expect('compreender').to separate_as %w(com pre en der)
    expect('caatinga').to separate_as %w(ca a tin ga)
    expect('atmosfera').to separate_as %w(at mos fe ra)

    expect('tuiuiú').to separate_as %w(tui ui ú)

    # I really don't buy the whole "comes from latin" thing.
    # Our separation if phonetic based, so, keep it that way!
    expect('abrupto').to separate_as %w(a brup to)
    expect('abruptamente').to separate_as %w(a brup ta men te)
    # For example, the word bellow is correctly separated
    # (as the dictionary says). =\
    expect('abrupção').to separate_as %w(a brup ção)

    expect('pais').to separate_as %w(pais)
    expect('país').to separate_as %w(pa ís)
  end

  it 'separates "amanhã"' do
    expect('amanhã').to separate_as %w(a ma nhã)
  end


  it 'separates "ainda"' do
    expect('ainda').to separate_as %w(a in da)
  end

  it 'separates "ruim"' do
    expect('ruim').to separate_as %w(ru im)
  end

  it 'separates "acuidade" and "ajuizar"' do
    expect('acuidade').to separate_as %w(a cu i da de)
    expect('ajuizar').to separate_as %w(a ju i zar)
  end

  it 'separates "traidor"' do
    expect('traidor').to separate_as %w(trai dor)
  end

  it 'separates "arruinar"' do
    expect('arruinar').to separate_as %w(ar ru i nar)
  end

  it 'separates "ou"' do
    expect('cenoura').to separate_as %w(ce nou ra)
    expect('roupa').to separate_as %w(rou pa)
  end

  it 'separates "moinho"' do
    expect('moinho').to separate_as %w(mo i nho)
  end

  it 'separates "fluido"' do
    expect('fluido').to separate_as %w(flu i do)
  end

  it 'separates "cair"' do
    expect('cair').to separate_as %w(ca ir)
  end

  it 'separates "saudade" and "saudoso"' do
    expect('saudade').to separate_as %w(sau da de)
    expect('saudoso').to separate_as %w(sau do so)
  end

  it 'separates "rein..." and "reim..."' do
    expect('reimplantar').to separate_as %w(re im plan tar)
    expect('reinventar').to separate_as %w(re in ven tar)
    expect('reincidência').to separate_as %w(re in ci dên ci a)
    expect('deixar').to separate_as %w(dei xar)
    expect('pereira').to separate_as %w(pe rei ra)
  end

  it 'separates "transeunte"' do
    expect('transeunte').to separate_as %w(tran se un te)
  end

  it 'separates "doido"' do
    expect('doído').to separate_as %w(do í do)
    expect('doido').to separate_as %w(doi do)
  end
end
