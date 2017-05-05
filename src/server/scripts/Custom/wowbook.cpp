#include <time.h>
#include "ScriptPCH.h"
#include "Language.h"
#include "ScriptedGossip.h"
//#include "bot_ai.h"

#define CLASS_GOSSIP_MESSAGE(x) 71000+x
#define HERO_GOSSIP_MESSAGE DEFAULT_GOSSIP_MESSAGE
#define MEMBERSHIP_GOSSIP_MESSAGE DEFAULT_GOSSIP_MESSAGE
#define CHARACTER_GOSSIP_MESSAGE DEFAULT_GOSSIP_MESSAGE
#define REWARD_GOSSIP_MESSAGE DEFAULT_GOSSIP_MESSAGE
#define SHOP_GOSSIP_MESSAGE DEFAULT_GOSSIP_MESSAGE

#define GOSSIP_SENDER_MENU_BACK 0

//Main
#define GOSSIP_SENDER_WOWBOOK_CHARACTER GOSSIP_ACTION_INFO_DEF + 1
#define GOSSIP_SENDER_WOWBOOK_HEROS GOSSIP_ACTION_INFO_DEF + 2
#define GOSSIP_SENDER_WOWBOOK_SHOP GOSSIP_ACTION_INFO_DEF + 3
#define GOSSIP_SENDER_WOWBOOK_REWARD GOSSIP_ACTION_INFO_DEF + 4
#define GOSSIP_SENDER_WOWBOOK_MEMBERSHIP GOSSIP_ACTION_INFO_DEF + 5
#define GOSSIP_SENDER_WOWBOOK_END GOSSIP_SENDER_WOWBOOK_MEMBERSHIP

//Membership
#define GOSSIP_SENDER_MEMBERSHIP_START GOSSIP_SENDER_WOWBOOK_END
#define GOSSIP_SENDER_MEMBERSHIP_TYPE GOSSIP_SENDER_MEMBERSHIP_START + 1
#define GOSSIP_SENDER_MEMBERSHIP_POINTS GOSSIP_SENDER_MEMBERSHIP_START + 2
#define GOSSIP_SENDER_MEMBERSHIP_VIP_EXPIRE GOSSIP_SENDER_MEMBERSHIP_START + 3
#define GOSSIP_SENDER_MEMBERSHIP_BANK GOSSIP_SENDER_MEMBERSHIP_START + 4
#define GOSSIP_SENDER_MEMBERSHIP_MAILBOX GOSSIP_SENDER_MEMBERSHIP_START + 5
#define GOSSIP_SENDER_MEMBERSHIP_VIP_BUY GOSSIP_SENDER_MEMBERSHIP_START + 6
#define GOSSIP_SENDER_MEMBERSHIP_GOLD_BUY GOSSIP_SENDER_MEMBERSHIP_START + 7
#define GOSSIP_SENDER_MEMBERSHIP_5000GOLD_BUY GOSSIP_SENDER_MEMBERSHIP_START + 8
#define GOSSIP_SENDER_MEMBERSHIP_10000GOLD_BUY GOSSIP_SENDER_MEMBERSHIP_START + 9
#define GOSSIP_SENDER_MEMBERSHIP_22000GOLD_BUY GOSSIP_SENDER_MEMBERSHIP_START + 10
#define GOSSIP_SENDER_MEMBERSHIP_35000GOLD_BUY GOSSIP_SENDER_MEMBERSHIP_START + 11
#define GOSSIP_SENDER_MEMBERSHIP_60000GOLD_BUY GOSSIP_SENDER_MEMBERSHIP_START + 12
#define GOSSIP_SENDER_MEMBERSHIP_BUYCONFIRM GOSSIP_SENDER_MEMBERSHIP_START + 13
#define GOSSIP_SENDER_MEMBERSHIP_END GOSSIP_SENDER_MEMBERSHIP_BUYCONFIRM

//Heros
#define GOSSIP_SENDER_HEROS_START GOSSIP_SENDER_MEMBERSHIP_END
#define GOSSIP_SENDER_WOWBOOK_HERO_DETAILS GOSSIP_SENDER_HEROS_START + 1
#define GOSSIP_SENDER_HEROS_END GOSSIP_SENDER_WOWBOOK_HERO_DETAILS

//Characters
#define GOSSIP_SENDER_CHARACTER_START GOSSIP_SENDER_HEROS_END
#define GOSSIP_SENDER_CHARACTER_FACTION GOSSIP_SENDER_CHARACTER_START + 1
#define GOSSIP_SENDER_CHARACTER_RACE GOSSIP_SENDER_CHARACTER_START + 2
#define GOSSIP_SENDER_CHARACTER_RENAME GOSSIP_SENDER_CHARACTER_START + 3
#define GOSSIP_SENDER_CHARACTER_LEVEL GOSSIP_SENDER_CHARACTER_START + 4
#define GOSSIP_SENDER_CHARACTER_CUSTOM GOSSIP_SENDER_CHARACTER_START + 5
#define GOSSIP_SENDER_CHARACTER_END GOSSIP_SENDER_CHARACTER_LEVEL

//Rewards
#define GOSSIP_SENDER_REWARD_START GOSSIP_SENDER_CHARACTER_END
#define GOSSIP_SENDER_REWARD_FRIENDS GOSSIP_SENDER_REWARD_START + 1
#define GOSSIP_SENDER_REWARD_FRIENDS_RAF GOSSIP_SENDER_REWARD_START + 2
#define GOSSIP_SENDER_REWARD_FRIENDS_TOTAL GOSSIP_SENDER_REWARD_START + 3
#define GOSSIP_SENDER_REWARD_FRIENDS_GETREWARD GOSSIP_SENDER_REWARD_START + 4
#define GOSSIP_SENDER_REWARD_PLAYEDTIME GOSSIP_SENDER_REWARD_START + 5
#define GOSSIP_SENDER_REWARD_PLAYEDTIME_TOTAL GOSSIP_SENDER_REWARD_START + 6
#define GOSSIP_SENDER_REWARD_PLAYEDTIME_GETREWARD GOSSIP_SENDER_REWARD_START + 7
#define GOSSIP_SENDER_HEROS_END GOSSIP_SENDER_WOWBOOK_HERO_DETAILS

//Shop
#define GOSSIP_SENDER_HEROS_START GOSSIP_SENDER_MEMBERSHIP_END
#define GOSSIP_SENDER_WOWBOOK_HERO_DETAILS GOSSIP_SENDER_HEROS_START + 1
#define GOSSIP_SENDER_HEROS_END GOSSIP_SENDER_WOWBOOK_HERO_DETAILS

class wowbook : public ItemScript
{
	private:
		uint32 currentBotClass;
		uint32 currentBot;
    public:
        wowbook() : ItemScript("wowbook") { }
 		bool OnUse(Player *player, Item *_item, SpellCastTargets const& /*targets*/)
		{
			if (player->IsInCombat())
			{
				CloseGossipMenuFor(player);
				ChatHandler(player->GetSession()).SendSysMessage(LANG_YOU_IN_COMBAT);
				return true;
			}
			else
			{
				ShowMainMenu(player, _item);
			}
			
			return true;
		}
		void ShowMainMenu(Player *player, Item *_item)
		{
			ClearGossipMenuFor(player);
			AddGossipItemFor(player, GOSSIP_ICON_DOT, player->GetSession()->GetTrinityString(LANG_WOWBOOK_MEMBERSHIP), GOSSIP_SENDER_MAIN, GOSSIP_SENDER_WOWBOOK_MEMBERSHIP);
			AddGossipItemFor(player, GOSSIP_ICON_DOT, player->GetSession()->GetTrinityString(LANG_WOWBOOK_SHOP), GOSSIP_SENDER_MAIN, GOSSIP_SENDER_WOWBOOK_SHOP);
			AddGossipItemFor(player, GOSSIP_ICON_DOT, player->GetSession()->GetTrinityString(LANG_WOWBOOK_CHARACTER), GOSSIP_SENDER_MAIN, GOSSIP_SENDER_WOWBOOK_CHARACTER);
			AddGossipItemFor(player, GOSSIP_ICON_DOT, player->GetSession()->GetTrinityString(LANG_WOWBOOK_PROMOTE), GOSSIP_SENDER_MAIN, GOSSIP_SENDER_WOWBOOK_REWARD);
			
			SendGossipMenuFor(player, DEFAULT_GOSSIP_MESSAGE, _item->GetGUID());
		}
		void ShowMembershipMenu(Player *player, Item *_item)
		{
			CloseGossipMenuFor(player);
			AddGossipItemFor(player, GOSSIP_ICON_DOT, Trinity::StringFormat(player->GetSession()->GetTrinityString(LANG_MEMBERSHIP_POINTS), player->GetSession()->GetWowPoint()).c_str(), GOSSIP_SENDER_WOWBOOK_MEMBERSHIP, GOSSIP_SENDER_MEMBERSHIP_POINTS);
			AddGossipItemFor(player, GOSSIP_ICON_DOT, Trinity::StringFormat(player->GetSession()->GetTrinityString(LANG_MEMBERSHIP_TYPE), player->GetSession()->GetMembershipType()).c_str(), GOSSIP_SENDER_WOWBOOK_MEMBERSHIP, GOSSIP_SENDER_MEMBERSHIP_TYPE);
			if (player->GetSession()->IsPremium())
			{
				AddGossipItemFor(player, GOSSIP_ICON_DOT, Trinity::StringFormat(player->GetSession()->GetTrinityString(LANG_MEMBERSHIP_VIP_EXPIRE), player->GetSession()->GetVIPExpireDate()).c_str(), GOSSIP_SENDER_WOWBOOK_MEMBERSHIP, GOSSIP_SENDER_MEMBERSHIP_VIP_EXPIRE);
			}
			AddGossipItemFor(player, GOSSIP_ICON_DOT, player->GetSession()->GetTrinityString(LANG_MEMBERSHIP_VIP_BUY), GOSSIP_SENDER_WOWBOOK_MEMBERSHIP, GOSSIP_SENDER_MEMBERSHIP_VIP_BUY, player->GetSession()->GetTrinityString(LANG_MEMBERSHIP_VIPBUYCONFIRM),0,false);
			AddGossipItemFor(player, GOSSIP_ICON_DOT, player->GetSession()->GetTrinityString(LANG_MEMBERSHIP_BANK), GOSSIP_SENDER_WOWBOOK_MEMBERSHIP, GOSSIP_SENDER_MEMBERSHIP_BANK);
			AddGossipItemFor(player, GOSSIP_ICON_DOT, player->GetSession()->GetTrinityString(LANG_MEMBERSHIP_MAILBOX), GOSSIP_SENDER_WOWBOOK_MEMBERSHIP, GOSSIP_SENDER_MEMBERSHIP_MAILBOX);
			AddGossipItemFor(player, GOSSIP_ICON_DOT, player->GetSession()->GetTrinityString(LANG_MEMBERSHIP_GOLD_BUY), GOSSIP_SENDER_WOWBOOK_MEMBERSHIP, GOSSIP_SENDER_MEMBERSHIP_GOLD_BUY);
			AddGossipItemFor(player, GOSSIP_ICON_DOT, player->GetSession()->GetTrinityString(LANG_MENU_NAME_BACK), GOSSIP_SENDER_WOWBOOK_MEMBERSHIP, GOSSIP_SENDER_MENU_BACK);

			SendGossipMenuFor(player, MEMBERSHIP_GOSSIP_MESSAGE, _item->GetGUID());
		}

		void ShowCharacterMenu(Player *player, Item *_item)
		{
			CloseGossipMenuFor(player);
			AddGossipItemFor(player, GOSSIP_ICON_DOT, player->GetSession()->GetTrinityString(LANG_CHARACTER_CHANGE_FACTION), GOSSIP_SENDER_WOWBOOK_CHARACTER, GOSSIP_SENDER_CHARACTER_FACTION, player->GetSession()->GetTrinityString(LANG_CHARACTER_FACTIONCONFIRM), 0, false);
			AddGossipItemFor(player, GOSSIP_ICON_DOT, player->GetSession()->GetTrinityString(LANG_CHARACTER_CHANGE_RACE), GOSSIP_SENDER_WOWBOOK_CHARACTER, GOSSIP_SENDER_CHARACTER_RACE, player->GetSession()->GetTrinityString(LANG_CHARACTER_RACECONFIRM), 0, false);
			AddGossipItemFor(player, GOSSIP_ICON_DOT, player->GetSession()->GetTrinityString(LANG_CHARACTER_RENAME), GOSSIP_SENDER_WOWBOOK_CHARACTER, GOSSIP_SENDER_CHARACTER_RENAME, player->GetSession()->GetTrinityString(LANG_CHARACTER_RENAMECONFIRM), 0, false);
			AddGossipItemFor(player, GOSSIP_ICON_DOT, player->GetSession()->GetTrinityString(LANG_CHARACTER_CUSTOM), GOSSIP_SENDER_WOWBOOK_CHARACTER, GOSSIP_SENDER_CHARACTER_CUSTOM, player->GetSession()->GetTrinityString(LANG_CHARACTER_CUSTOMCONFIRM), 0, false);
			AddGossipItemFor(player, GOSSIP_ICON_DOT, player->GetSession()->GetTrinityString(LANG_MENU_NAME_BACK), GOSSIP_SENDER_WOWBOOK_MEMBERSHIP, GOSSIP_SENDER_MENU_BACK);
			//AddGossipItemFor(player, GOSSIP_ICON_DOT, player->GetSession()->GetTrinityString(LANG_CHARACTER_CHANGE_LEVEL), GOSSIP_SENDER_WOWBOOK_CHARACTER, GOSSIP_SENDER_CHARACTER_LEVEL, player->GetSession()->GetTrinityString(LANG_CHARACTER_LEVELCONFIRM), 0, false);
			//AddGossipItemFor(player, GOSSIP_ICON_DOT, player->GetSession()->GetTrinityString(LANG_MEMBERSHIP_GOLD_BUY), GOSSIP_SENDER_WOWBOOK_CHARACTER, GOSSIP_SENDER_MEMBERSHIP_GOLD_BUY);
			//AddGossipItemFor(player, GOSSIP_ICON_DOT, player->GetSession()->GetTrinityString(LANG_MENU_NAME_BACK), GOSSIP_SENDER_WOWBOOK_CHARACTER, GOSSIP_SENDER_MENU_BACK);

			SendGossipMenuFor(player, MEMBERSHIP_GOSSIP_MESSAGE, _item->GetGUID());
		}

		void ShowRewardMenu(Player *player, Item *_item)
		{
			CloseGossipMenuFor(player);
			AddGossipItemFor(player, GOSSIP_ICON_DOT, player->GetSession()->GetTrinityString(LANG_REWARDS_FRIENDS), GOSSIP_SENDER_WOWBOOK_REWARD, GOSSIP_SENDER_REWARD_FRIENDS);
			AddGossipItemFor(player, GOSSIP_ICON_DOT, player->GetSession()->GetTrinityString(LANG_REWARDS_PLAYEDTIME), GOSSIP_SENDER_WOWBOOK_REWARD, GOSSIP_SENDER_REWARD_PLAYEDTIME);
			AddGossipItemFor(player, GOSSIP_ICON_DOT, player->GetSession()->GetTrinityString(LANG_MENU_NAME_BACK), GOSSIP_SENDER_WOWBOOK_REWARD, GOSSIP_SENDER_MENU_BACK);

			SendGossipMenuFor(player, REWARD_GOSSIP_MESSAGE, _item->GetGUID());
		}

		bool OnGossipSelect(Player *player, Item *_item, uint32 sender, uint32 uiAction)
		{
			if (player->IsInCombat())
			{
				CloseGossipMenuFor(player);
				ChatHandler(player->GetSession()).SendSysMessage(LANG_YOU_IN_COMBAT);
				return true;
			}

			if (sender == GOSSIP_SENDER_MAIN)
			{
				ClearGossipMenuFor(player);
				switch(uiAction)
				{
				/*case GOSSIP_SENDER_WOWBOOK_HEROS: //LANG_WOWBOOK_HEROS
					OnListHeroClasses(player, _item);
					break;*/
				case GOSSIP_SENDER_WOWBOOK_SHOP: //LANG_WOWBOOK_HEROS
					OnHandleShop(player, _item, sender, uiAction);
					break;
				case GOSSIP_SENDER_WOWBOOK_MEMBERSHIP: //LANG_WOWBOOK_QUERY_MEMBERSHIP
					OnHandleMembership(player, _item, sender, uiAction);
					break;
				case GOSSIP_SENDER_WOWBOOK_CHARACTER: //LANG_WOWBOOK_CHARACTER
					OnHandleCharacter(player, _item, sender, uiAction);
					break;
				case GOSSIP_SENDER_WOWBOOK_REWARD: 
					OnHandleReward(player, _item, sender, uiAction);
					break;
				default:
					break;
				}
			}
			else if (sender == GOSSIP_SENDER_WOWBOOK_HEROS) 
			{
				ClearGossipMenuFor(player);
				OnListHerosForClass(player, _item, uiAction);
			}
			else if (sender == GOSSIP_SENDER_WOWBOOK_MEMBERSHIP || sender == GOSSIP_SENDER_MEMBERSHIP_GOLD_BUY || sender == GOSSIP_SENDER_MEMBERSHIP_VIP_BUY)
			{
				OnHandleMembership(player, _item, sender, uiAction);
			}
			else if (sender == GOSSIP_SENDER_WOWBOOK_CHARACTER )
			{
				OnHandleCharacter(player, _item, sender, uiAction);
			}
			else if (sender == GOSSIP_SENDER_WOWBOOK_SHOP)
			{
				OnHandleShop(player, _item, sender, uiAction);
			}
			else if (sender == GOSSIP_SENDER_WOWBOOK_REWARD)
			{
				OnHandleReward(player, _item, sender, uiAction);
			}
			return true;
		}
		void OnShowHeroDetails(Player* player, Item *_item, uint32 heroId)
		{
			ObjectGuid guildHero = ObjectGuid(HighGuid::Unit, heroId);
			/*if (player->HaveBot(guildHero))
			{
				AddGossipItemFor(player, GOSSIP_ICON_DOT, player->GetSession()->GetTrinityString(LANG_WOWBOOK_SUMMON), GOSSIP_SENDER_WOWBOOK_HERO_DETAILS, heroId);
			}
			currentBot = heroId;
			AddGossipItemFor(player, GOSSIP_ICON_DOT, player->GetSession()->GetTrinityString(LANG_SLOT_NAME_BACK), GOSSIP_SENDER_WOWBOOK_HERO_DETAILS, 0);
			SendGossipMenuFor(player, heroId, _item->GetGUID());*/
		}
		void OnListHerosForClass(Player* player, Item *_item, uint32 uiAction)
		{
			CloseGossipMenuFor(player);
			ClearGossipMenuFor(player);
			/*if (uiAction > BOT_CLASS_NORMAL_END)//show hero details, uiAction is hero id
			{
				OnShowHeroDetails(player, _item, uiAction);
			}
			else
			{
				uint8 botclass = uiAction;
				currentBotClass = botclass;
				uint8 localeIndex = ChatHandler(player->GetSession()).GetSessionDbLocaleIndex();
				CreatureTemplateContainer const* ctc = sObjectMgr->GetCreatureTemplates();
				int idx = 0;
				for (CreatureTemplateContainer::const_iterator itr = ctc->begin(); itr != ctc->end()&&idx<10; ++itr)
				{
					uint32 id = itr->second.Entry;
					std::string name;
					
					if (id < BOT_ENTRY_BEGIN || id > BOT_ENTRY_END) continue;
					uint32 trainer_class = itr->second.trainer_class;
					if (trainer_class != botclass) continue;
					
					if (CreatureLocale const* creatureLocale = sObjectMgr->GetCreatureLocale(id))
					{
						if (creatureLocale->Name.size() > localeIndex && !creatureLocale->Name[localeIndex].empty())
						{
							name = creatureLocale->Name[localeIndex];
						}
					}
					else
						name = itr->second.Name;

					if (name.empty())
						continue;
					++idx;
					AddGossipItemFor(player, GOSSIP_ICON_DOT, name, GOSSIP_SENDER_WOWBOOK_HEROS, id);
				}
			}

			*/
			SendGossipMenuFor(player, CLASS_GOSSIP_MESSAGE(currentBotClass), _item->GetGUID());
		}
		void OnListHeroClasses(Player* player, Item *_item)
		{
			/*CloseGossipMenuFor(player);
			for (int i = BOT_CLASS_NORMAL_START; i <= BOT_CLASS_NORMAL_END; i++)
			{
				if (i == 10)continue;
				AddGossipItemFor(player, GOSSIP_ICON_DOT, player->GetSession()->GetTrinityString(LANG_HEROS_CLASS_BASE+i), GOSSIP_SENDER_WOWBOOK_HEROS, i);
			}
			*/
			SendGossipMenuFor(player, HERO_GOSSIP_MESSAGE, _item->GetGUID());
		}
		
		void OnHandleMembership(Player* player, Item *_item, uint32 sender, uint32 uiAction)
		{
			ClearGossipMenuFor(player);
			if (sender == GOSSIP_SENDER_MAIN)
			{
				ShowMembershipMenu(player, _item);
			}
			else if (sender == GOSSIP_SENDER_WOWBOOK_MEMBERSHIP)
			{
				switch (uiAction)
				{
				case GOSSIP_SENDER_MEMBERSHIP_VIP_BUY:
					/*CloseGossipMenuFor(player);
					AddGossipItemFor(player, GOSSIP_ICON_DOT, player->GetSession()->GetTrinityString(LANG_MEMBERSHIP_BUYCONFIRM), GOSSIP_SENDER_MEMBERSHIP_VIP_BUY, GOSSIP_SENDER_MEMBERSHIP_BUYCONFIRM);
					AddGossipItemFor(player, GOSSIP_ICON_CHAT, player->GetSession()->GetTrinityString(LANG_MENU_NAME_BACK), GOSSIP_SENDER_MEMBERSHIP_VIP_BUY, GOSSIP_SENDER_MENU_BACK);
					SendGossipMenuFor(player, MEMBERSHIP_VIP_BUY_GOSSIP_MESSAGE, _item->GetGUID());*/
					if (player->GetSession()->GetWowPoint() < 20)
					{
						//not enough DPs
						ChatHandler(player->GetSession()).SendSysMessage(LANG_MEMBERSHIP_NOT_ENOUGH_DP);
						ChatHandler(player->GetSession()).SetSentErrorMessage(true);
					}
					else
					{
						if (player->GetSession()->BuyVip())
						{
							ChatHandler(player->GetSession()).SendSysMessage(LANG_MEMBERSHIP_BUY_SUCCESS);
						}
						else
						{
							ChatHandler(player->GetSession()).SendSysMessage(LANG_MEMBERSHIP_BUY_FAIL);
						}
					}
					break;
				case GOSSIP_SENDER_MEMBERSHIP_GOLD_BUY:
					CloseGossipMenuFor(player);
					AddGossipItemFor(player, GOSSIP_ICON_DOT, player->GetSession()->GetTrinityString(LANG_MEMBERSHIP_5000GOLD_BUY), GOSSIP_SENDER_MEMBERSHIP_GOLD_BUY, GOSSIP_SENDER_MEMBERSHIP_5000GOLD_BUY);
					AddGossipItemFor(player, GOSSIP_ICON_DOT, player->GetSession()->GetTrinityString(LANG_MEMBERSHIP_10000GOLD_BUY), GOSSIP_SENDER_MEMBERSHIP_GOLD_BUY, GOSSIP_SENDER_MEMBERSHIP_10000GOLD_BUY);
					AddGossipItemFor(player, GOSSIP_ICON_DOT, player->GetSession()->GetTrinityString(LANG_MEMBERSHIP_22000GOLD_BUY), GOSSIP_SENDER_MEMBERSHIP_GOLD_BUY, GOSSIP_SENDER_MEMBERSHIP_22000GOLD_BUY);
					AddGossipItemFor(player, GOSSIP_ICON_DOT, player->GetSession()->GetTrinityString(LANG_MEMBERSHIP_35000GOLD_BUY), GOSSIP_SENDER_MEMBERSHIP_GOLD_BUY, GOSSIP_SENDER_MEMBERSHIP_35000GOLD_BUY);
					AddGossipItemFor(player, GOSSIP_ICON_DOT, player->GetSession()->GetTrinityString(LANG_MEMBERSHIP_60000GOLD_BUY), GOSSIP_SENDER_MEMBERSHIP_GOLD_BUY, GOSSIP_SENDER_MEMBERSHIP_60000GOLD_BUY);
					//AddGossipItemFor(player, GOSSIP_ICON_CHAT, player->GetSession()->GetTrinityString(LANG_MENU_NAME_BACK), GOSSIP_SENDER_MEMBERSHIP_GOLD_BUY, GOSSIP_SENDER_MENU_BACK);
					SendGossipMenuFor(player, MEMBERSHIP_GOSSIP_MESSAGE, _item->GetGUID());
					break;
				case GOSSIP_SENDER_MEMBERSHIP_BANK:
					if (player->GetSession()->IsPremium() && sWorld->getBoolConfig(COMMAND_MAIL_PREMIUM))
					{
						//Different Checks
						if (player->IsInCombat() || player->IsInFlight() || player->GetMap()->IsBattlegroundOrArena() || player->HasStealthAura() || player->HasFlag(UNIT_FIELD_FLAGS_2, UNIT_FLAG2_FEIGN_DEATH) || player->isDead())
						{
							ChatHandler(player->GetSession()).SendSysMessage(LANG_PREMIUM_CANT_DO);
							ChatHandler(player->GetSession()).SetSentErrorMessage(true);
							return;
						}
						player->GetSession()->SendShowBank(player->GetGUID());
					}
					else
					{
						ChatHandler(player->GetSession()).SendSysMessage(LANG_PREMIUM_CANT_DO);
						ChatHandler(player->GetSession()).SetSentErrorMessage(true);
					}
					break;
				case GOSSIP_SENDER_MEMBERSHIP_MAILBOX:
					if (player->GetSession()->IsPremium() && sWorld->getBoolConfig(COMMAND_MAIL_PREMIUM))
					{
						//Different Checks
						if (player->IsInCombat() || player->IsInFlight() || player->GetMap()->IsBattlegroundOrArena() || player->HasStealthAura() || player->HasFlag(UNIT_FIELD_FLAGS_2, UNIT_FLAG2_FEIGN_DEATH) || player->isDead())
						{
							ChatHandler(player->GetSession()).SendSysMessage(LANG_PREMIUM_CANT_DO);
							ChatHandler(player->GetSession()).SetSentErrorMessage(true);
							return;
						}

						player->GetSession()->SendShowMailBox(player->GetGUID());
					}
					else {
						ChatHandler(player->GetSession()).SendSysMessage(LANG_PREMIUM_CANT_DO);
						ChatHandler(player->GetSession()).SetSentErrorMessage(true);
					}
					break;
				case GOSSIP_SENDER_MENU_BACK:
					CloseGossipMenuFor(player);
					ShowMainMenu(player,_item);
					break;
				default:
					OnHandleMembership(player, _item, GOSSIP_SENDER_MAIN , GOSSIP_SENDER_WOWBOOK_MEMBERSHIP);
					break;
				}
			}
			else if (sender == GOSSIP_SENDER_MEMBERSHIP_GOLD_BUY)
			{
				CloseGossipMenuFor(player);
				switch (uiAction)
				{
					case GOSSIP_SENDER_MEMBERSHIP_5000GOLD_BUY:
						player->GetSession()->BuyGold(5000);
						break;
					case GOSSIP_SENDER_MEMBERSHIP_10000GOLD_BUY:
						player->GetSession()->BuyGold(10000);
						break;
					case GOSSIP_SENDER_MEMBERSHIP_22000GOLD_BUY:
						player->GetSession()->BuyGold(22000);
						break;
					case GOSSIP_SENDER_MEMBERSHIP_35000GOLD_BUY:
						player->GetSession()->BuyGold(35000);
						break;
					case GOSSIP_SENDER_MEMBERSHIP_60000GOLD_BUY:
						player->GetSession()->BuyGold(60000);
						break;
				}
			}
			else if (sender == GOSSIP_SENDER_MEMBERSHIP_VIP_BUY)
			{
				CloseGossipMenuFor(player);
				if (uiAction == GOSSIP_SENDER_MEMBERSHIP_BUYCONFIRM)
				{
					if (player->GetSession()->GetWowPoint() < 20)
					{
							//not enough DPs
							ChatHandler(player->GetSession()).SendSysMessage(LANG_MEMBERSHIP_NOT_ENOUGH_DP);
							ChatHandler(player->GetSession()).SetSentErrorMessage(true);
					}
					else
					{
						if (player->GetSession()->BuyVip())
						{
							ChatHandler(player->GetSession()).SendSysMessage(LANG_MEMBERSHIP_BUY_SUCCESS);
						}
						else
						{
							ChatHandler(player->GetSession()).SendSysMessage(LANG_MEMBERSHIP_BUY_FAIL);
						}
					}
				}
				else if (uiAction == GOSSIP_SENDER_MENU_BACK)
				{
					CloseGossipMenuFor(player);
					ShowMembershipMenu(player, _item);
				}
			}
		}

		void OnHandleShop(Player* player, Item *_item, uint32 sender, uint32 uiAction)
		{

		}
		
		void OnHandleReward(Player* player, Item *_item, uint32 sender, uint32 uiAction)
		{
			ClearGossipMenuFor(player);
			if (sender == GOSSIP_SENDER_MAIN)
			{
				ShowRewardMenu(player, _item);
			}
			else if (sender == GOSSIP_SENDER_WOWBOOK_REWARD)
			{
				CloseGossipMenuFor(player);
				switch (uiAction)
				{
				case GOSSIP_SENDER_REWARD_FRIENDS:
					AddGossipItemFor(player, GOSSIP_ICON_DOT, Trinity::StringFormat(player->GetSession()->GetTrinityString(LANG_REWARDS_FRIENDS_RAF), player->GetSession()->GetRAFId()).c_str(), GOSSIP_SENDER_WOWBOOK_REWARD, GOSSIP_SENDER_REWARD_FRIENDS_RAF);
					AddGossipItemFor(player, GOSSIP_ICON_DOT, Trinity::StringFormat(player->GetSession()->GetTrinityString(LANG_REWARDS_FRIENDS_TOTAL), player->GetSession()->GetRAFNum()).c_str(), GOSSIP_SENDER_WOWBOOK_REWARD, GOSSIP_SENDER_REWARD_FRIENDS_TOTAL);
					AddGossipItemFor(player, GOSSIP_ICON_DOT, Trinity::StringFormat(player->GetSession()->GetTrinityString(LANG_REWARDS_FRIENDS_GETREWARD), player->GetSession()->GetRAFRewards()).c_str(), GOSSIP_SENDER_WOWBOOK_REWARD, GOSSIP_SENDER_REWARD_FRIENDS_GETREWARD);
					
					SendGossipMenuFor(player, MEMBERSHIP_GOSSIP_MESSAGE, _item->GetGUID());
					break;
				case GOSSIP_SENDER_REWARD_PLAYEDTIME:
					AddGossipItemFor(player, GOSSIP_ICON_DOT, Trinity::StringFormat(player->GetSession()->GetTrinityString(LANG_REWARDS_PLAYEDTIME_TOTAL), player->GetFormatPlayedTime()).c_str(), GOSSIP_SENDER_WOWBOOK_REWARD, GOSSIP_SENDER_REWARD_PLAYEDTIME_TOTAL);
					AddGossipItemFor(player, GOSSIP_ICON_DOT, Trinity::StringFormat(player->GetSession()->GetTrinityString(LANG_REWARDS_PLAYEDTIME_GETREWARD), player->GetOnlinePlayedTimeReward()).c_str(), GOSSIP_SENDER_WOWBOOK_REWARD, GOSSIP_SENDER_REWARD_PLAYEDTIME_GETREWARD);

					SendGossipMenuFor(player, MEMBERSHIP_GOSSIP_MESSAGE, _item->GetGUID());
					break;
				case GOSSIP_SENDER_REWARD_PLAYEDTIME_GETREWARD:
					player->GetSession()->CharacterRename();
					break;
				case GOSSIP_SENDER_MENU_BACK:
					ShowMainMenu(player, _item);
					break;
				default:
					OnHandleReward(player, _item, GOSSIP_SENDER_MAIN, GOSSIP_SENDER_WOWBOOK_REWARD);
					break;
				}
			}
		}

		void OnHandleCharacter(Player* player, Item *_item, uint32 sender, uint32 uiAction)
		{
			ClearGossipMenuFor(player);
			if (sender == GOSSIP_SENDER_MAIN)
			{
				ShowCharacterMenu(player, _item);
			}
			else if (sender == GOSSIP_SENDER_WOWBOOK_CHARACTER)
			{
				CloseGossipMenuFor(player);
				switch (uiAction)
				{
				case GOSSIP_SENDER_CHARACTER_FACTION:
					player->GetSession()->CharacterChangeFaction();
					break;
				case GOSSIP_SENDER_CHARACTER_RACE:
					player->GetSession()->CharacterChangeRace();
					break;
				case GOSSIP_SENDER_CHARACTER_RENAME:
					player->GetSession()->CharacterRename();
					break;
				case GOSSIP_SENDER_CHARACTER_CUSTOM:
					player->GetSession()->CharacterCustomize();
					break;
				case GOSSIP_SENDER_MENU_BACK:
					ShowMainMenu(player, _item);
					break;
				default:
					OnHandleCharacter(player, _item, GOSSIP_SENDER_MAIN, GOSSIP_SENDER_WOWBOOK_CHARACTER);
					break;
				}
			}
		}
};



void AddSC_wowbook()
{
    new wowbook();
}