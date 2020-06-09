local personagem = {}
local alien1 = {}
local alien2 = {}
local alien3 = {}
local alien_frame = 1
local personagem_frame = 1
local orda = {}
local alien_anim_time = 0
local aux = 0
local alien_speed = 0.2
local vel_gradual_alien = 0.2
local descida_alien = 15
local temTiro = 0
local tiro_x = 0 
local tiro_y = 0
local vel_tiro = 7
local comecou = 0
local logo = love.graphics.newImage("logo.png")
local logo_x = 150
local logo_y = 500
local apareceTexto = 0
local texto_x = 160
local texto_y = 400
local texto_frame = 1 
local texto = {}
local texto_anim_time = 0
local acabou = 0
local game_over = love.graphics.newImage("game_over_01.png")
local ganhou = 0 
local voce_venceu = love.graphics.newImage("voce_venceu_01.png")
local vel_personagem = 3
local animacao = 0
local raios = {}
local raios_y = {}
local raios_x = {}
local quantidade_raios = 50
local tam_font = 20
local score = 0
local mil = 0
local min = 0
local seg = 0
local help = love.graphics.newImage("texto_inicio_03.png")
local tiro_aliens = {}
local tem_tiro_a = {}
local alien_porcent = 10
local vel_tiro_alien = 0.5

function alien_atira()
  for j = 1, 11, 1 do
    if tem_tiro_a[j] == 1 then
      tiro_aliens[j].y = tiro_aliens[j].y + vel_tiro_alien
    end
    if tiro_aliens[j].y == 600 then 
      tem_tiro_a[j] = 0
    end
    if checkBoxCollision(tiro_aliens[j].x, tiro_aliens[j].y, tiro_aliens[j].width, tiro_aliens[j].height, jogador.x, jogador.y, jogador.width, jogador.height) then
      jogador.collided = true
      acabou = 1
    end
    for i = 1, 11, 1 do
      if love.math.random()*100000 <= alien_porcent then
        if tem_tiro_a[i] == 0 then
          tem_tiro_a[i] = 1
          for y = 1, 5, 1 do
            if orda[y][i].collided == false then
              tiro_aliens[i].y = orda[y][i].y
              tiro_aliens[i].x = orda[y][i].x
            end
          end
        end
      end
    end
  end 
end
function inicializaPersonagens()
  for l = 1, 11, 1 do 
    tem_tiro_a[l] = 0
    tiro_a = {
          image = love.graphics.newImage("tiro_02.png"),
          x = 0,
          y = 0,
          width = 15,
          height = 10,
          collided = false,
        }
    tiro_aliens[l] = tiro_a
  end
  for l = 1, quantidade_raios, 1 do 
    raios[l] = love.graphics.newImage("tiro_01.png")
    raios_y[l] = math.random()*600 + 500
    raios_x[l] = math.random()*800
  end
  for x = 1, 3, 1 do
    alien1[x] = love.graphics.newImage("alien_polvo_0"..x..".png")
    alien2[x] = love.graphics.newImage("alien_chifrudo_0"..x..".png")
    alien3[x] = love.graphics.newImage("alien_cabecudo_0"..x..".png")
    if x < 3 then 
      personagem[x] = love.graphics.newImage("personagem_0"..x..".png")
    end
  end
  local k = 1
  for i = 1, 5, 1 do
    local linha = {}
    for j = 1, 11, 1 do
       alien = {
          x = 25 * j,
          y = 25 * k,
          width = 15,
          height = 10,
          collided = false,
          aux = 0
        }
        linha[j] = alien
    end
    k = k+1
    orda[i] = linha
  end
end
function printaAnimacao()
  for l = 1, quantidade_raios, 1 do
    love.graphics.draw(raios[l],raios_x[l],raios_y[l])
  end
end
function animacao_f()
  if animacao == 1 then
    for l = 1, quantidade_raios, 1 do
      raios_y[l] = raios_y[l] - 20
      if raios_y[l] <= -10 then
        raios_y[l]= 600
      end
    end
  end
end
function ganhar()
  local aux = 0 
   for i = 1, 5, 1 do
    for j = 1, 11, 1 do
      if orda[i][j].collided == false then
        aux = 1
        break
      end
    end
  end
  if aux == 0 then
    ganhou = 1
    animacao = 1
  end
end
function gameOver()
  for j = 1, 11, 1 do
    for i = 1, 5, 1 do
      if orda[i][j].collided == false then
        if checkBoxCollision(orda[i][j].x, orda[i][j].y, orda[i][j].width, orda[i][j].height, jogador.x, jogador.y, jogador.width, jogador.height) or orda[i][j].y >= jogador.y then
            acabou = 1
            personagem_frame = 2
            jogador.collided = true
        end
      end
    end 
  end
end
function alteraTexto ()
   if texto_anim_time == 20 then
    if texto_frame == 1 then
      texto_frame = 2
    else
      texto_frame = 1
    end
    texto_anim_time = 0
  else 
    texto_anim_time = texto_anim_time + 1
  end
end
function comeca()
  if logo_y > 150 then
    logo_y = logo_y - 5
  else
    apareceTexto = 1
    alteraTexto()
  end
  if love.keyboard.isDown("return") then
    comecou = 1
  end
end
function inicializaTexto()
  texto[1] = love.graphics.newImage("texto_inicio_01.png")
  texto[2] = love.graphics.newImage("texto_inicio_02.png")
end
function trocaFantasiaAlien()
  if alien_anim_time == 20 then
    if alien_frame == 1 then
      alien_frame = 2
    else
      alien_frame = 1
    end
    alien_anim_time = 0
  else 
    alien_anim_time = alien_anim_time + 1
  end
end
function printaOrda()
  for i = 1, 5, 1 do
    for j = 1, 11, 1 do
      if i == 1 or i == 2 then
        if orda[i][j].collided == false then
          love.graphics.draw(alien1[alien_frame],orda[i][j].x,orda[i][j].y)
        else
          if orda[i][j].aux <= 1 then
            love.graphics.draw(alien1[3],orda[i][j].x,orda[i][j].y)
            orda[i][j].aux = orda[i][j].aux + 1
          end
        end
      end
      if i == 3 or i == 4 then
        if orda[i][j].collided == false then
          love.graphics.draw(alien2[alien_frame],orda[i][j].x,orda[i][j].y)
        else
          if orda[i][j].aux <= 1 then
            love.graphics.draw(alien2[3],orda[i][j].x,orda[i][j].y)
            orda[i][j].aux = orda[i][j].aux + 1
          end
        end
      end
      if i == 5 then
        if orda[i][j].collided == false then
          love.graphics.draw(alien3[alien_frame],orda[i][j].x,orda[i][j].y)
        else
          if orda[i][j].aux <= 1 then
            love.graphics.draw(alien3[3],orda[i][j].x,orda[i][j].y)
            orda[i][j].aux = orda[i][j].aux + 1
          end
        end
      end
    end
  end
end
function checkBoxCollision(x1,y1,w1,h1,x2,y2,w2,h2)
  return x1 < x2+w2 and x2 < x1+w1 and y1 < y2+h2 and y2 < y1+h1
end

function movePersonagem()
  if love.keyboard.isDown("left") then
    if jogador.x >= 10 then
      jogador.x = jogador.x - vel_personagem
    end
  end
  if love.keyboard.isDown("right") then 
    if jogador.x <= 770 then
      jogador.x = jogador.x + vel_personagem
    end
  end
end
function mexerAlien()
  function andaDir()
    for j = 1, 11, 1 do
      for i = 1, 5, 1 do
        orda[i][j].x = orda[i][j].x + alien_speed
      end
    end
  end
  function andaEsq()
    for j = 1, 11, 1 do
      for i = 1, 5, 1 do
        orda[i][j].x = orda[i][j].x - alien_speed
      end
    end
  end
  function desceAliens()
    for j = 1, 11, 1 do
      for i = 1, 5, 1 do
        orda[i][j].y =  orda[i][j].y + descida_alien
      end
    end
  end
  if aux == 0 then
    andaDir()
    if orda[5][11].x >= 770 then
      aux = 1
      alien_speed = alien_speed + vel_gradual_alien
      desceAliens()
    end
  else
    andaEsq()
    if orda[1][1].x <= 10 then
      aux = 0
      alien_speed = alien_speed + vel_gradual_alien
      desceAliens()
    end
  end
end
function alienMorreu()
for j = 1, 11, 1 do
    for i = 1, 5, 1 do
      if checkBoxCollision(orda[i][j].x, orda[i][j].y, orda[i][j].width, orda[i][j].height, tiro_x, tiro_y, tiro.width, tiro.height)and temTiro == 1 then
        if orda[i][j].collided == false then
          temTiro = 0
        	if acabou == 0 then
			
          		score = score + 100

			end
        end
        orda[i][j].collided = true 
        
      end
    end
  end
end

function atira()
  if temTiro == 1 then
    tiro_y = tiro_y - vel_tiro
    if tiro_y <= 0 then
      temTiro = 0
    end
  end
  if love.keyboard.isDown("space") then
    if temTiro == 0 then
      tiro_x = jogador.x + 1
      tiro_y = jogador.y - 20
    end
    temTiro = 1 
  end
end
function love.load()
  font = love.graphics.newFont("FSEX300.ttf",tam_font)
  love.graphics.setFont(font)
  inicializaTexto()
  inicializaPersonagens()
  jogador = {
    x = 400,
    y = 550,
    width = 8,
    height = 8,
    collided = false
  }
  tiro = {
    image = love.graphics.newImage("tiro_01.png"),
    width = 10,
    height = 8,
    collided = false
  }
end

function tempo()
  if ganhou == 0 then
    mil = mil + 1
    if mil == 99 then
      seg = seg + 1
      mil = 0
    end
    if seg == 59 then
      min = min + 1
      seg = 0
    end
  end
end
function love.update(dt)
  if comecou == 0 then
    comeca()
  else
    trocaFantasiaAlien()
    mexerAlien()
    movePersonagem()
    atira()
    alienMorreu()
    gameOver()
    ganhar()
    animacao_f()
    tempo()
    alien_atira()
  end
end

function love.draw() 
  local total = 0
  if comecou ~= 0 then
    if ganhou == 0 then
      if acabou == 0 then
        love.graphics.setColor(255,255,255) 
        love.graphics.draw(personagem[personagem_frame],jogador.x,jogador.y)
        if temTiro == 1 then  
          love.graphics.draw(tiro.image,tiro_x,tiro_y)
        end
        printaOrda()
        for o = 1, 11, 1 do
          if tem_tiro_a[o] == 1 then
            love.graphics.draw(tiro_aliens[o].image,tiro_aliens[o].x,tiro_aliens[o].y) ----------------------
          end
        end
        love.graphics.print("Time: "..min..":"..seg.."."..mil,450,0)
        love.graphics.print("Score: "..score,600,0)
      else
        love.graphics.draw(game_over,150,200)
        love.graphics.print("Pontuação: "..score,300,350)
      end
    else
      tiro.image = love.graphics.newImage("tiro_02.png")
      love.graphics.draw(voce_venceu,250,200)
      total = total + mil + (seg * 100) + ( min * 600)
      total = 10000 - total
      love.graphics.print("Score: "..score,300,300)
      love.graphics.print("Bônus de tempo: "..total,300,320)
      love.graphics.print("______________________",300,330)
      love.graphics.print("Total: "..score+total,300,350)
      love.graphics.draw(personagem[personagem_frame],jogador.x,jogador.y)
      printaAnimacao()
      if temTiro == 1 then  
          love.graphics.draw(tiro.image,tiro_x,tiro_y)
      end
    end
  else
    love.graphics.draw(logo,logo_x,logo_y)
    if apareceTexto == 1 then
      love.graphics.draw(texto[texto_frame],texto_x,texto_y)
      love.graphics.draw(help,texto_x,texto_y+30)
    end
  end
end