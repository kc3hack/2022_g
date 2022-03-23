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


    private void Start()
    {
        beGameOver = false;
        dropFlames = 0;
        gameStop = false;
        gameoverCountText = gameoverCountTextGO.GetComponent<Text>();
    }

    // Triggerの中に何かが入った時
    private void OnTriggerEnter2D(Collider2D collision)
    {
        // もし入ったものにItemタグが付いているならば
        if (collision.tag == "Item")
        {
            if (gameStop != true)
            {
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
        
        dropFlames = 0;
    }


    public void Giveup()
    {
        if (igm.currentItemGO != null)
        {
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
        }

        if (dropFlames >= 150) {
            dropFlames = 0;
            gameStop = true;
            gameoverCountTextGO.SetActive(false);
            igm.doGameOver();
        }
    }

}
