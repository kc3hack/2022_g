using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Item : MonoBehaviour
{
    Rigidbody2D rb;
    bool moved;

    private void Start()
    {
        rb = GetComponent<Rigidbody2D>();
        rb.bodyType = RigidbodyType2D.Kinematic;
        moved = false;
    }

    void OnMouseDrag()
    {
        if (moved == false)
        {
            Vector2 pointScreen = new Vector2(Input.mousePosition.x, Input.mousePosition.y);

            Vector2 pointWorld = Camera.main.ScreenToWorldPoint(pointScreen);

            this.transform.position = pointWorld;
        }
    }


    private void OnMouseUp()
    {
        if (moved == false)
        {
            rb.bodyType = RigidbodyType2D.Dynamic;
            moved = true;
        }
    }
}
