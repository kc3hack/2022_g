using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DropTrigger : MonoBehaviour
{

    public bool beGameOver;
    [SerializeField] InGameManager igm;
    [SerializeField] GameObject rotateButtonL;
    [SerializeField] GameObject rotateButtonR;


    private void Start()
    {
        beGameOver = false;
    }

    // Triggerの中に何かが入った時
    private void OnTriggerEnter2D(Collider2D collision)
    {
        // もし入ったものにItemタグが付いているならば
        if (collision.tag == "Item")
        {
            beGameOver = true;
            rotateButtonL.SetActive(false);
            rotateButtonR.SetActive(false);
            igm.addScore(-50);
        }
    }



}
