using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DropTrigger : MonoBehaviour
{
    private void OnTriggerEnter2D(Collider2D collision)
    {
        if (collision.tag == "Item") {
            Debug.Log("失敗");
        }
    }
}
