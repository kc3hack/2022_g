using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DropTrigger : MonoBehaviour
{

    public bool beGameOver;
    [SerializeField] InGameManager igm;
    [SerializeField] GameObject rotateButtonL;
    [SerializeField] GameObject rotateButtonR;
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
                beGameOver = true;
                rotateButtonL.SetActive(false);
                rotateButtonR.SetActive(false);
                igm.addScore(-50);
                dropFlames = 0;
            }
            Destroy(collision.gameObject);
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
