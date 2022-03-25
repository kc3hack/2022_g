using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class HowToPlayManager : MonoBehaviour
{ 
    public bool beingHowToPlay;
    [SerializeField] private GameObject howToPlay;

    [SerializeField] AudioSourceManager asm;
    [SerializeField] private AudioClip decideAC;
    [SerializeField] private AudioClip closeAC;

    private void Start()
    {
        beingHowToPlay = false;
    }


    public void popHowToPlay()
    {
        asm.playSe(decideAC);
        beingHowToPlay = true;
        howToPlay.SetActive(true);
    }


    public void closeHowToPlay()
    {
        asm.playSe(closeAC);
        beingHowToPlay = false;
        howToPlay.SetActive(false);
    }

}
