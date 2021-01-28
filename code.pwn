#include <http>
#include <a_samp>
#include <a_players>

#define VK_ACCES_TOKEN "токен сообщества"
#define VK_API_VERSION "5.126"

/*предположим, что в моде уже имеется енум и переменная игроков
в енуме которого есть поле vk_id, connect_ip, name

enum users....

new user_info[MAX_PLAYERS][users];

*/

public OnPlayerConnect(playerid)
{
  	SendClientMessage(playerid, 0xff6600ff, "Вы подключились к серверу!");
  
  	new str_vk_message[144];
  	format(str_vk_message, sizeof(str_vk_message), "Ваш аккаунт %s был подключен к серверу!\nIP: %s", user_info[playerid][name], user_info[playerid][connect_ip]);
  	vk_send_message(user_info[playerid][vk_id], str_vk_message);
}

stock vk_send_message(user_id, text)
{
	new url_vk_api[264];
	new random_id = random(1000)+1;
	format(url_vk_api, sizeof(url_vk_api), "https://api.vk.com/method/message.send?user_id=%s&random_id=%d&message=%s&access_token=%s&v=%s", 
    user_id, random_id, text, VK_ACCES_TOKEN, VK_API_VERSION);
	if(HTTP(user_id, HTTP_GET, url_vk_api, "", "MyHttpResponse") != 1) print("Ошибка отправления запроса VK_API");
}
