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
    [SerializeField] GameObject gameoverCountTextGO;
    Text gameoverCountText;
    float gameoverCount;
    private int dropFlames;
    private bool gameStop;

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
            asm.playSe(stopAC);
            igm.currentItemGO.SetActive(false);
            makeGameOver();
        }
    }


    private void FixedUpdate()
    {
        if (beGameOver) {
            dropFlames++;
            gameoverCount -= 0.02f;
            gameoverCountText.text = gameoverCount.ToString("f2");
            if ((gameoverCount <= 2.00f) && (playCountSe2 == false)) {
                asm.playSe(countAC);
                playCountSe2 = true;
            }
            if ((gameoverCount <= 1.00f) && (playCountSe1 == false))
            {
                asm.playSe(countAC);
                playCountSe1 = true;
            }
        }

        if (dropFlames >= 150) {
            dropFlames = 0;
            gameStop = true;
            gameoverCountTextGO.SetActive(false);
            igm.doGameOver();
        }
    }

}
