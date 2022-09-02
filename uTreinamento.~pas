unit uTreinamento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, DBGrids, Buttons, DB, DBClient, Menus;

type
  TfrmPrincipal = class(TForm)
    pnPrincipal: TPanel;
    edIdade: TEdit;
    edSalario: TEdit;
    btPostar: TBitBtn;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    cbEstadoCivil: TComboBox;
    cdsCadastraPessoas: TClientDataSet;
    dsCadastraPessoas: TDataSource;
    Label6: TLabel;
    edId: TEdit;
    mnMenu: TMainMenu;
    Consultas1: TMenuItem;
    frmHabitantes: TMenuItem;
    edCapturaExport: TEdit;
    svArquivo: TSaveDialog;
    edCapturaImport: TEdit;
    opAbrirArquivo: TOpenDialog;
    btImportarDados: TBitBtn;
    btSalvarComo: TBitBtn;
    edSexo: TComboBox;
    btResultado: TButton;
    gbCadastro: TGroupBox;
    gbImpExp: TGroupBox;
    rgSelecionaOpcao: TRadioGroup;
    Label1: TLabel;
    Label7: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btPostarClick(Sender: TObject);
    procedure frmHabitantesClick(Sender: TObject);
    procedure btImportarDadosClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure edIdExit(Sender: TObject);
    procedure edIdadeExit(Sender: TObject);
    procedure edSalarioExit(Sender: TObject);
    procedure edSexoExit(Sender: TObject);
    procedure cbEstadoCivilExit(Sender: TObject);
    procedure btResultadoClick(Sender: TObject);
    procedure rgSelecionaOpcaoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses uConsulta, Math, StrUtils, uFiltro, uProcedimentosPadroes;

{$R *.dfm}

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  cdsCadastraPessoas := TClientDataSet.Create(self);                            //criando minhas colunas

  cdsCadastraPessoas.FieldDefs.Add('BDID',          ftInteger);                 //primary key
  cdsCadastraPessoas.FieldDefs.Add('bdIDADE',       ftString, 50);              //coluna idade
  cdsCadastraPessoas.FieldDefs.Add('bdSEXO',        ftString, 10);              //coluna Genero
  cdsCadastraPessoas.FieldDefs.Add('bdSALARIO',     ftCurrency);                //coluna salario
  cdsCadastraPessoas.FieldDefs.Add('bdESTADOCIVIL', ftString, 20);              //coluna estado civil

  cdsCadastraPessoas.IndexDefs.Add('iID', 'bdID',       [ixPrimary,ixUnique]);  //atribuindo chave primaria para meu ID
  cdsCadastraPessoas.IndexDefs.Add('iIDADE', 'bdIDADE', [ixCaseInsensitive]);

  cdsCadastraPessoas.CreateDataSet;

  cdsCadastraPessoas.Open;

  dsCadastraPessoas.DataSet := cdsCadastraPessoas;                              //datasource ta linkado a minha tabela
end;

procedure TfrmPrincipal.btPostarClick(Sender: TObject);

var
  wIdade : string;
begin
  wIdade := '';
  wIdade := edIdade.Text;

  if fVerificaIdade(wIdade) then                                                //a função ta retornando um valor booleano e o parametro dentro dela é a condição da minha função
     begin
       MessageDlg('Este valor para Idade não é possível, por favor, tente novamente.',
       mtError, [mbOK], 0);
       Exit;
     end
  else
    begin                                                                       //inicio do processamento para salvar os dados na tabela
      cdsCadastraPessoas.IndexFieldNames := 'bdID';                             //organizando minha tabela para fazer as buscas

      if cdsCadastraPessoas.findKey([edId.Text]) then                           //Esse commando findKey ta fazendo a localização se tem algum valor igual ao que está sendo verificado dentro do colchete
         cdsCadastraPessoas.Edit                                                //se encontrar um igual, vai habilitar a a tabela para edição
      else
        cdsCadastraPessoas.Insert;                                              //se não encontrar, vai habilitar a tabela para edição

      cdsCadastraPessoas.FieldByName('bdID').AsInteger       := StrToInt(edId.Text);
      cdsCadastraPessoas.FieldByName('bdIDADE').AsInteger    := StrToInt(edIdade.Text);
      cdsCadastraPessoas.FieldByName('bdSEXO').AsString      := edSexo.Text;
      cdsCadastraPessoas.FieldByName('bdSALARIO').AsCurrency := StrToCurr(edSalario.Text);
      if cbEstadoCivil.ItemIndex      = 0 then
         cdsCadastraPessoas.FieldByName('bdESTADOCIVIL').AsString := cbEstadoCivil.Text
      else if cbEstadoCivil.ItemIndex = 1 then
         cdsCadastraPessoas.FieldByName('bdESTADOCIVIL').AsString := cbEstadoCivil.Text
      else if cbEstadoCivil.ItemIndex = 2 then
         cdsCadastraPessoas.FieldByName('bdESTADOCIVIL').AsString := cbEstadoCivil.Text
      else
         cdsCadastraPessoas.FieldByName('bdESTADOCIVIL').AsString := cbEstadoCivil.Text;

      cdsCadastraPessoas.Post;
      MessageDlg('Dados salvo com sucesso', mtInformation, [mbOK], 0);
    end;
end;

procedure TfrmPrincipal.frmHabitantesClick(Sender: TObject);
var
  wConsulta: TfrmConsulta;
begin
  wConsulta := TfrmConsulta.Create(Self);
  wConsulta.wCdsConsulta := cdsCadastraPessoas;
  wConsulta.Show;
end;

procedure TfrmPrincipal.btImportarDadosClick(Sender: TObject);                  //processamento Importar
begin
  opAbrirArquivo.DefaultExt := 'txt';
  opAbrirArquivo.Filter := 'Arquivo de Texto'+'*.txt';
  btSalvarComo.Enabled  := False;

  if opAbrirArquivo.Execute then
     edCapturaImport.Text := opAbrirArquivo.FileName;

  if edCapturaImport.MaxLength < 255 then
    begin
      edCapturaImport.Hint := edCapturaImport.Text;
      edCapturaImport.ShowHint := True;
    end;
end;

procedure TfrmPrincipal.BitBtn1Click(Sender: TObject);                          //processamento Exportar
begin
  btImportarDados.Enabled := False;
  svArquivo.DefaultExt    := 'txt';                                             //sempre salvando os arquivos em txt
  svArquivo.Filter        := 'Arquivo de Texto'+'*.txt';

  if svArquivo.Execute then                                  //no clique do botão, estou verificando se o openDialog está sendo executado
     begin
       edCapturaExport.Text  := svArquivo.FileName;                             //quando o usuário escolher o diretório, vai mandar o caminho para dentro do edit
       if edCapturaExport.MaxLength < 255 then
          begin
            edCapturaExport.Hint     := edCapturaExport.Text;
            edCapturaExport.ShowHint := True;
          end;
     end;

end;

procedure TfrmPrincipal.edIdExit(Sender: TObject);                              //Verificação Campo Id
var
  wTextoIdVazio: string;
begin
  if fEntradaValoresEmCampos(edId.Text, 1) then                      //verifica letra
     edId.SetFocus;

  if fEntradaValoresEmCampos(edId.Text, 2, edId.Text) then                      //verifica apenas 3 caracteres para o campo ID
     edId.SetFocus;

  wTextoIdVazio := edId.Text;
  if fExisteCamposVazios(wTextoIdVazio) then
     begin
       MessageDlg('O Campo Id não pode ser vazio', mtError, [mbOK], 0);
       edId.SetFocus;
       exit;
     end;

  if not (cdsCadastraPessoas.IsEmpty) then
     begin
       if cdsCadastraPessoas.FindKey([edId.Text]) then                        //traz os valores da tabela para seus edits
          begin
            edIdade.Text := IntToStr(cdsCadastraPessoas.fieldByName('bdIDADE').AsInteger);
            edSexo.Text := cdsCadastraPessoas.fieldByName('bdSEXO').AsString;
            edSalario.Text := IntToStr(cdsCadastraPessoas.FieldByName('bdSALARIO').AsInteger);
            cbEstadoCivil.Text := cdsCadastraPessoas.fieldByName('bdESTADOCIVIL').AsString;
          end;
     end;

end;

procedure TfrmPrincipal.edIdadeExit(Sender: TObject);                           //Verificação Campo Idade
var
  wTextoIdadeVazio: String;
begin
  if fEntradaValoresEmCampos(edIdade.Text , 1) then                        //verifica letra
     edIdade.SetFocus;

  wTextoIdadeVazio := edIdade.Text;
  if fExisteCamposVazios(wTextoIdadeVazio) then
     begin
       MessageDlg('O Campo Idade não pode ser vazio', mtError, [mbOK], 0);
       edIdade.SetFocus;
       exit;
     end;

end;

procedure TfrmPrincipal.edSalarioExit(Sender: TObject);                         //verificação Campo Salário
var
 wTextoSalarioVazio  : String;
begin
  if fEntradaValoresEmCampos(edSalario.Text, 1) then
     edSalario.SetFocus;

  wTextoSalarioVazio := edSalario.Text;
  if fExisteCamposVazios(wTextoSalarioVazio) then
     begin
       MessageDlg('O Campo Salário não pode ser vazio', mtError, [mbOK], 0);
       edSalario.SetFocus;
       exit;
     end;
end;

procedure TfrmPrincipal.edSexoExit(Sender: TObject);                            //Verificação Campo Gênero
var
  wTextoSexoVazio: String;
begin
  if edSexo.Text <> '' then
     begin
       if fEntradaValoresEmCampos(edSexo.Text, 0) then                        //Mensagem dos números
          edSexo.SetFocus
       else if fEntradaValoresEmCampos(edSexo.Text, 4) then                        //Mensagem unica para esse campo
          edSexo.SetFocus;
     end;

  wTextoSexoVazio := edSexo.Text;
  if fExisteCamposVazios(wTextoSexoVazio) then
     begin
       MessageDlg('O campo Gênero não pode ser vazio', mtError, [mbOK], 0);
       edSexo.SetFocus;
     end;

end;

procedure TfrmPrincipal.cbEstadoCivilExit(Sender: TObject);                     //verificação Campo Estado Civil
var
  wTextoEstCivilVazio: string;
begin
  if cbEstadoCivil.Text <> '' then
     begin
       if fEntradaValoresEmCampos(cbEstadoCivil.Text, 0) then                 //verificando numeros no Cbox
          cbEstadoCivil.SetFocus
       else if fEntradaValoresEmCampos(cbEstadoCivil.Text, 4) then                 //verificando os itens do Cbox
          cbEstadoCivil.SetFocus;
     end;

  wTextoEstCivilVazio := cbEstadoCivil.Text;
  if fExisteCamposVazios(wTextoEstCivilVazio) then
     begin
       MessageDlg('O campo Estado Civil não pode ser vazio', mtError, [mbOK], 0);
       cbEstadoCivil.SetFocus;
     end;
end;

procedure TfrmPrincipal.btResultadoClick(Sender: TObject);
var
  wMenorIdade,
  wMaiorIdade,
  wContS,
  wSalarioAte500,
  wQtdRegistros,
  wCont19,
  wCont29,
  wCont39,
  wCont49,
  wCont59,
  wCont69,
  wCont79,
  wCont89,
  wContAcima89 : Integer;

  wSomaSalario,
  wMediaSalario : Currency;

  wMostraResultado : Boolean;
begin
  IF rgSelecionaOpcao.ItemIndex = 0 THEN                              //EXPORTAR
     BEGIN
       if cdsCadastraPessoas.IsEmpty then
          begin
            if MessageDlg('Não existem dados na tabela, deseja continuar?', mtConfirmation, [mbYes,mbNo], 0)
            = mrYes then
               begin
                 btImportarDados.Enabled := False;
                 if edCapturaExport.Text = '' then
                    begin
                      MessageDlg('Escolha um caminho para salvar.', mtError, [mbOK], 0);
                      exit;
                    end
                 else
                    begin
                      pSalvaArquivoEmDir;                                        //chamando minha procedure
                      MessageDlg('Diretório Salvo', mtInformation,[mbOK], 0);
                      edCapturaExport.Clear;
                    end;

               end;
          end
       else if edCapturaExport.Text = '' then
          begin
            MessageDlg('Escolha um caminho para salvar.', mtError, [mbOK], 0);
            exit;
          end
       else
          begin
            pSalvaArquivoEmDir;                                                //chamando minha procedure
            MessageDlg('Diretório Salvo', mtInformation,[mbOK], 0);
            edCapturaExport.Clear;
          end;
     END
  ELSE IF rgSelecionaOpcao.itemIndex = 1 THEN                                      //IMPORTAR
     BEGIN
       btSalvarComo.Enabled := False;
       if edCapturaImport.Text = '' then
          begin
            MessageDlg('Selecione um Arquivo para importar.', mtError, [mbOK], 0);
            Exit;
          end
       else
          begin
            pInsereAquivoNaTabela;                                             //chamando minha procedure que vai executar a importação
            MessageDlg('Arquivo Importado', mtInformation, [mbOK], 0);         //apresentar a mensagem
            edCapturaImport.Clear;                                             //da um Clear no meu edit
          end;

     END
  ELSE IF rgSelecionaOpcao.ItemIndex = 2  THEN                                    //RESULTADOS
     BEGIN
       if cdsCadastraPessoas.IsEmpty then
          begin
            MessageDlg('Dados em registro não encontrado', mtError, [mbOK], 0);
            exit;
          end
       else
          begin
            wSomaSalario     := 0;
            wMediaSalario    := 0;
            wContS           := 0;
            wSalarioAte500   := 0;
            wCont19          := 0;
            wCont29          := 0;
            wCont39          := 0;
            wCont49          := 0;
            wCont59          := 0;
            wCont69          := 0;
            wCont79          := 0;
            wCont89          := 0;
            wContAcima89     := 0;

            wMostraResultado := True;

            wQtdRegistros    := cdsCadastraPessoas.RecordCount;

            cdsCadastraPessoas.IndexFieldNames := 'bdIDADE';                   //organizando as idades da menor a maior
            cdsCadastraPessoas.First;
            while not cdsCadastraPessoas.Eof    do                             //inicio da rotina Média salarios
              begin
                wSomaSalario := wSomaSalario + cdsCadastraPessoas.FieldByName
                ('bdSALARIO').AsInteger;                                       //fim da rotina média Salário

                if cdsCadastraPessoas.RecNo = 1 then                           //inicio da rotina da menor idade
                   wMenorIdade := cdsCadastraPessoas.FieldByName('bdIDADE').AsInteger;
                                                                                //Fim da Rotina Menor Idade
                wSalarioAte500 := cdsCadastraPessoas.FieldByName('bdSALARIO').AsInteger;  //inicio rotina salarios ate 500
                if wSalarioAte500 <= 500        then
                   Inc(wContS);                                                //Fim Rotina Salarios ate 500
                                                                                //Inicio da Rotina de separação por faixa etária
                if cdsCadastraPessoas.FieldByName('bdIDADE').AsInteger <= 19 then
                   inc(wCont19)
                else if cdsCadastraPessoas.FieldByName('bdIDADE').AsInteger <= 29 then
                   inc(wCont29)
                else if cdsCadastraPessoas.FieldByName('bdIDADE').AsInteger <= 39 then
                   inc(wCont39)
                else if cdsCadastraPessoas.FieldByName('bdIDADE').AsInteger <= 49 then
                   inc(wCont49)
                else if cdsCadastraPessoas.FieldByName('bdIDADE').AsInteger <= 59 then
                   inc(wCont59)
                else if cdsCadastraPessoas.FieldByName('bdIDADE').AsInteger <= 69 then
                   inc(wCont69)
                else if cdsCadastraPessoas.FieldByName('bdIDADE').AsInteger <= 79 then
                   inc(wCont79)
                else if cdsCadastraPessoas.FieldByName('bdIDADE').AsInteger <= 89 then
                   inc(wCont89)
                else
                   inc(wContAcima89);                             //Fim da Rotina de separação por faixa etária
                                                                                //Inicio da Rotina para a Maior Idade
                cdsCadastraPessoas.Next;
                if cdsCadastraPessoas.Eof then
                   wMaiorIdade := cdsCadastraPessoas.FieldByName('bdIDADE').AsInteger; //Fim da Rotina Maior Idade.

              end;                                                             //Fim do laço

            wMediaSalario := wSomaSalario / wQtdRegistros;                     //Mostrando os resultados do Exercício
            ShowMessage('A Média dos Salários é: ' + CurrToStr(wMediaSalario));
            ShowMessage('A Menor Idade é: '        + IntToStr(wMenorIdade));
            ShowMessage('A Maior Idade é: '        + IntToStr(wMaiorIdade));
            ShowMessage('Existem '+IntToStr(wContS)+' Pessoas com salário de até 500 Reais.');
            ShowMessage('Existem '+IntToStr(wQtdRegistros)+' Pessoas no Total.');
            if wCont19 <> 0 then
               ShowMessage('Existem '+IntToStr(wCont19)+' Pessoas Até 19 Anos');

            if wCont29 <> 0 then
               ShowMessage('Existem '+IntToStr(wCont29)+' Pessoas Até 29 Anos');

            if wCont39 <> 0 then
               ShowMessage('Existem '+IntToStr(wCont39)+' Pessoas Até 39 Anos');

            if wCont49 <> 0 then
               ShowMessage('Existem '+IntToStr(wCont49)+' Pessoas Até 49 Anos');

            if wCont59 <> 0 then
               ShowMessage('Existem '+IntToStr(wCont59)+' Pessoas Até 59 Anos');

            if wCont69 <> 0 then
               ShowMessage('Existem '+IntToStr(wCont69)+' Pessoas Até 69 Anos');

            if wCont79 <> 0 then
               ShowMessage('Existem '+IntToStr(wCont79)+' Pessoas Até 79 Anos');

            if wCont89 <> 0 then
               ShowMessage('Existem '+IntToStr(wCont89)+' Pessoas Até 89 Anos');

            if wContAcima89 <> 0 then
               ShowMessage('Existem '+IntToStr(wContAcima89)+' Pessoas Acima de 89 Anos');
          end;

     END;

end;

procedure TfrmPrincipal.rgSelecionaOpcaoClick(Sender: TObject);
begin
  if rgSelecionaOpcao.ItemIndex = 0 then
     begin
       btImportarDados.Enabled := False;
       edCapturaImport.Clear;
       btSalvarComo.Enabled    := True;
     end;

  if rgSelecionaOpcao.itemIndex = 1 then
     begin
       btImportarDados.Enabled := True;
       btSalvarComo.Enabled    := False;
       edCapturaExport.Clear;
     end;

  if rgSelecionaOpcao.ItemIndex = 2 then
     begin
       btImportarDados.Enabled := False;
       btSalvarComo.Enabled    := False;
       edCapturaExport.Clear;
       edCapturaImport.Clear;
     end;
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
  btImportarDados.Enabled := False;
end;

procedure TfrmPrincipal.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if ftabEnter(Key) then
end;

end.
