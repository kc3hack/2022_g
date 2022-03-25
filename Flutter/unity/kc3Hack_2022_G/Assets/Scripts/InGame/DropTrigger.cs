using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class DropTrigger : MonoBehaviour
{

    public bool beGameOver;
    [SerializeField] InGameManager igm;
    [SerializeField] GameObject rotateButtonL;
    [SerializeField] GameObject rotateButtonR;
    [SerializeField] GameObject giveupButton;
    [SerializeField] private GameObject giveupCancelButton;//ギブアップをキャンセルするボタン
    [SerializeField] GameObject gameoverCountTextGO;
    Text gameoverCountText;
    float gameoverCount;
    private int dropFlames;
    private bool gameStop;
    private bool giveupManage = false;//giveupボタンが押されているときはtrue

    AudioSourceManager asm;
    [SerializeField] AudioClip fallAC;
    [SerializeField] AudioClip stopAC;
    [SerializeField] AudioClip countAC;
    bool playCountSe1, playCountSe2;


    private void Start()
    {
        beGameOver = false;
        dropFlames = 0;
        gameStop = false;
        gameoverCountText = gameoverCountTextGO.GetComponent<Text>();
        asm = GameObject.Find("AudioSourceManager").GetComponent<AudioSourceManager>();
        playCountSe1 = false;
        playCountSe2 = false;
    }

    // Triggerの中に何かが入った時
    private void OnTriggerEnter2D(Collider2D collision)
    {
        // もし入ったものにItemタグが付いているならば
        if (collision.tag == "Item")
        {
            if (gameStop != true)
            {
                asm.playSe(fallAC);
                makeGameOver();
                igm.addScore(-50);
                igm.DropItems++;//落としたアイテムの数を数える
            }
            Destroy(collision.gameObject);
        }
    }


    // ギブアップ時含め、GameOver前の処理
    public void makeGameOver()
    {
        beGameOver = true;
        rotateButtonL.SetActive(false);
        rotateButtonR.SetActive(false);
        giveupButton.SetActive(false);
        gameoverCountTextGO.SetActive(true);
        gameoverCount = 3.00f;
        gameoverCountText.text = gameoverCount.ToString("f2");

        playCountSe1 = false;
        playCountSe2 = false;

        dropFlames = 0;
    }


    public void Giveup()
    {
        if (igm.currentItemGO != null)
        {
            giveupCancelButton.SetActive(true);
            giveupManage = true;

            asm.playSe(stopAC);
            igm.currentItemGO.SetActive(false);
            makeGameOver();
        }
    }

    //giveupをキャンセルする→続ける
    //giveupの処理をひっくり返しただけ(時間は触らず)
    public void GiveupCancel()
    {
        if (giveupManage == true)
        {
            beGameOver = false;
            rotateButtonL.SetActive(true);
            rotateButtonR.SetActive(true);
            giveupButton.SetActive(true);
            gameoverCountTextGO.SetActive(false);

            igm.currentItemGO.SetActive(true);

            playCountSe1 = true;
            playCountSe2 = true;

            dropFlames = 0;
            giveupManage = false;
            giveupCancelButton.SetActive(false);
        }
    }

    private void FixedUpdate()
    {
        if (beGameOver)
        {
            dropFlames++;
            gameoverCount -= 0.02f;
            gameoverCountText.text = gameoverCount.ToString("f2");

            // 残り2秒の時に音を鳴らす
            if ((gameoverCount <= 2.00f) && (playCountSe2 == false))
            {
                asm.playSe(countAC);
                playCountSe2 = true;
            }

            // 残り1秒の時に音を鳴らす
            if ((gameoverCount <= 1.00f) && (playCountSe1 == false))
            {
                asm.playSe(countAC);
                playCountSe1 = true;
            }
        }

        if (dropFlames >= 150)
        {
            dropFlames = 0;
            gameStop = true;
            gameoverCountTextGO.SetActive(false);
            igm.doGameOver();
        }
    }

}
