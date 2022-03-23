using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DropTrigger : MonoBehaviour
{

    public bool beGameOver;
    [SerializeField] InGameManager igm;
    [SerializeField] GameObject rotateButtonL;
    [SerializeField] GameObject rotateButtonR;
    [SerializeField] GameObject giveupButton;
    private int dropFlames;
    private bool gameStop;


    private void Start()
    {
        beGameOver = false;
        dropFlames = 0;
        gameStop = false;
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
        }

        if (dropFlames >= 150) {
            dropFlames = 0;
            gameStop = true;
            igm.doGameOver();
        }
    }

}
