unit uProcedimentosPadroes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, DBGrids, Buttons, DB, DBClient, Menus;


procedure pSalvaArquivoEmDir;
procedure pInsereAquivoNaTabela;
function fEntradaValoresEmCampos(prTextoEdit: String; prTipoFiltro: Integer;
                                 prTamCampo: string = '0'): Boolean;

function fVerificaIdade(var prIdade: string): Boolean;

function fExisteCamposVazios(var prCamposVazios: String): Boolean;

function ftabEnter(prTeclado: Char): Boolean;

var
wSLRecebeDadosDaTabela,
wSLRecebeDadosDoTxt: TStringList;


implementation

uses uConsulta, uFiltro, Math, StrUtils, uTreinamento;

function fEntradaValoresEmCampos(prTextoEdit: String; prTipoFiltro: Integer;    //1º FUNÇÃO
                                   prTamCampo: string = '0'): Boolean;
const
  cArrayEC: array [1..4] of string = ('CASADO','SOLTEIRO','DIVORCIADO','VIUVO');
var
  wI : Integer;

begin
  Result := False;
  case prTipoFiltro of
    0: if ((prTextoEdit >= '0') and (prTextoEdit <= '9')) then                  //só letras
          begin
            Result := True;
            MessageDlg('Não é possível digitar números nesse campo.', mtError, [mbOK], 0);
            exit;
          end
       else
          Result := False;

    1: for wI := 1 to Length(prTextoEdit) do                                    //só número
         begin
           if not (prTextoEdit[wI] in ['1'..'9']) then
              begin
                Result := True;
                MessageDlg('Valor Inválido para esse Campo', mtError, [mbOK], 0);
                Exit;
              end
           else
              Result := False;
         end;

    2: if Length(prTamCampo) > 3 then                                           //campo aceita apenas 3 digitos.
          begin
             Result := True;
             MessageDlg('É permitido apenas 3 caracteres nesse Campo', mtError, [mbOK], 0);
             exit;
          end;

    3: if Length(prTamCampo) > 1 then                                           //campo aceita apenas 1 caracter.
          begin
            Result := True;
            MessageDlg('É permitido apenas 1 caracter nesse Campo', mtError, [mbOK], 0);
            exit;
          end;

    4: if prTextoEdit = 'NENHUM' then                                           //solução para todos os tipos de Cbox
          begin
            Result := True;
            MessageDlg('Escolha Inválida', mtError, [mbOK], 0);
            exit;
          end
       else
          Result := False;

    {   solução 2
    for wCont := 0 to 1                                do                        //verificando entrada do genero
         begin
           Result := False;
           if prTextoEdit = 'MASCULINO'                   then
              wMasculino := prTextoEdit;
           if prTextoEdit = 'FEMININO'                    then
              wFeminino  := prTextoEdit;
           if (wMasculino = '') and (wFeminino = '')      then
              begin
                Result := True;
                MessageDlg('Apenas MASCULINO ou FEMININO Nesse Campo', mtError, [mbOK], 0);
                exit;
              end;
         end;

    5: for wCont := Low(cArrayEC) to High(cArrayEC)       do
         begin
           Result := False;
           if prTextoEdit = cArrayEC[1] then
              wCasado := prTextoEdit;
           if prTextoEdit = cArrayEC[2] then
              wSolteiro := prTextoEdit;
           if prTextoEdit = cArrayEC[3] then
              wDivorciado := prTextoEdit;
           if prTextoEdit = cArrayEC[4] then
              wViuvo := prTextoEdit;
           if (wCasado = '') and (wSolteiro = '') and (wDivorciado = '') and (wViuvo = '') then
              begin
                Result := True;
                MessageDlg('Selecione apenas os valores Pré-Definidos no campo', mtError, [mbOK], 0);
                exit;
              end;
         end;
       }
  end;

end;

function fVerificaIdade(var prIdade: string): Boolean;                          //2º FUNÇÃO
begin
  if (StrToInt(prIdade) > 120) or (StrToInt(prIdade) = 0)  then
     Result := True
  else
     Result  := False;
end;

function fExisteCamposVazios(var prCamposVazios: String): Boolean;               //3º FUNÇÃO
begin
  Result := False;
  if prCamposVazios =  '' then
     Result := True
  else
     Result := False;

end;

function ftabEnter(prTeclado: Char): Boolean;                                   //4º FUNÇÃO
begin
  if prTeclado = #13 then
     begin
       frmPrincipal.Perform(wm_Nextdlgctl, 0, 0);
       Result := True;
     end;
end;

procedure pInsereAquivoNaTabela;                                                //1º PROCEDURE
var
  wI    : Integer;
  wTexto: String;

begin
  //INICIO
  wSLRecebeDadosDoTxt := TStringList.Create;                                     //criando minha nova stringList
  wSLRecebeDadosDoTxt.LoadFromFile(frmPrincipal.edCapturaImport.Text);                        //COMANDO para pegar os dados do arquivo de acordo com o caminho selecionado
  frmPrincipal.cdsCadastraPessoas.EmptyDataSet;                                               //limpando todos os conteúdos de todos os campos para receber os novos.

  frmPrincipal.cdsCadastraPessoas.IndexFieldNames := 'bdID';                                  //organizando os ids em ordem crescente
  For wI := 0 to wSLRecebeDadosDoTxt.Count-1 do
    begin
      frmPrincipal.cdsCadastraPessoas.Insert;                                                 //modo inserção
      wTexto := wSLRecebeDadosDoTxt[wI];                                         //recebendo o conteudo de cada posição da string list
                                                                                 //inicio da rotina para armazenar os dados na tabela.
      frmPrincipal.cdsCadastraPessoas.FieldByName('bdID').AsInteger := strToInt(Copy(wTexto,1,pos(',',wTexto)-1));
      Delete(wTexto,1,pos(',',wTexto));

      frmPrincipal.cdsCadastraPessoas.FieldByName('bdIDADE').AsInteger  := StrToInt(Copy(wTexto,1, pos(',',wTexto)-1));
      Delete(wTexto,1,pos(',',wTexto));

      frmPrincipal.cdsCadastraPessoas.FieldByName('bdSEXO').AsString := Copy(wTexto,1,pos(',',wTexto)-1 );
      Delete(wTexto,1,pos(',',wTexto));

      frmPrincipal.cdsCadastraPessoas.FieldByName('bdSALARIO').AsCurrency := StrToCurr(Copy(wTexto,1,pos(',',wTexto)-1));
      Delete(wTexto,1,pos(',',wTexto));

      frmPrincipal.cdsCadastraPessoas.FieldByName('bdESTADOCIVIL').AsString := wTexto;
      Delete(wTexto,1,pos(',',wTexto));

      frmPrincipal.cdsCadastraPessoas.Post;                                                   //vai para a próxima linha.
    end;
  //FIM
end;

procedure pSalvaArquivoEmDir;                                                   //2º PROCEDURE
begin
  wSLRecebeDadosDaTabela := TStringList.Create;                                 //criando a string que vai receber os dados das colunas da tabela
  frmPrincipal.cdsCadastraPessoas.First;
  while not frmprincipal.cdsCadastraPessoas.Eof do
    begin                                                                       //adicionando para dentro da stringList
      wSLRecebeDadosDaTabela.Add(IntToStr(frmPrincipal.cdsCadastraPessoas.fieldbyName('bdID').AsInteger)+','+
      IntTostr(frmPrincipal.cdsCadastraPessoas.FieldByName('bdIDADE').AsInteger)+','+
      frmPrincipal.cdsCadastraPessoas.FieldByName('bdSEXO').AsString+','+
      CurrToStr(frmPrincipal.cdsCadastraPessoas.FieldByName('bdSALARIO').AsCurrency)+','+
      frmPrincipal.cdsCadastraPessoas.FieldByName('bdESTADOCIVIL').AsString);

      frmPrincipal.cdsCadastraPessoas.Next;

    end;
  wSLRecebeDadosDaTabela.SaveToFile(frmPrincipal.edCapturaExport.Text);

end;

end.
